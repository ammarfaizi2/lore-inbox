Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263494AbRFANGr>; Fri, 1 Jun 2001 09:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263495AbRFANGi>; Fri, 1 Jun 2001 09:06:38 -0400
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:23730 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S263494AbRFANGZ>; Fri, 1 Jun 2001 09:06:25 -0400
Date: Fri, 1 Jun 2001 15:06:22 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for
 realthis
In-Reply-To: <E155oW2-0000Ta-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106011503030.18082-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jun 2001, Alan Cox wrote:

> I am sure that to an unpriviledged application reporting back the same result
> as we saw last time we asked the hardware unless it is over 30 seconds old
> will work fine. Maybe 10 for link partner ?

No way! If I implement a HA application which depends on link status, I
want the info to be accurate, I don't want to know that 30 seconds ago I
had good link.

IMHO, rate limiting is the only solution.

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

