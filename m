Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263490AbRFAM45>; Fri, 1 Jun 2001 08:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263473AbRFAM4r>; Fri, 1 Jun 2001 08:56:47 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:26013 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263490AbRFAM42>;
	Fri, 1 Jun 2001 08:56:28 -0400
Message-ID: <3B1790FB.82FC9251@mandrakesoft.com>
Date: Fri, 01 Jun 2001 08:56:27 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for realthis
In-Reply-To: <E155oP7-0000Sl-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > In both of these situations, calling the ioctls without priveleges is
> > quite useful, so maybe rate-limiting for ioctls and proc files like this
> > would be a good idea in general.

> Many of them (like the MII and APM ones) the result can be cached

Only some of them can be cached...  (some of the MIIs in some drivers
are already cached, in fact)   you can't cache stuff like what your link
partner is advertising at the moment, or what your battery status is at
the moment.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
