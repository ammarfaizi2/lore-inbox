Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263553AbRFAOrY>; Fri, 1 Jun 2001 10:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263546AbRFAOrO>; Fri, 1 Jun 2001 10:47:14 -0400
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:20661 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S263545AbRFAOqz>; Fri, 1 Jun 2001 10:46:55 -0400
Date: Fri, 1 Jun 2001 16:46:50 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mark Frazer <mark@somanetworks.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for
In-Reply-To: <E155q3E-0000bH-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106011643250.18082-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jun 2001, Alan Cox wrote:

> Which is worse. I cat the proc file a few times and your HA app is unlucky. It
> now gets *NO* data for five minutes. If we cache the values it gets approximate
> data

Rate limit: current values, sysadmin knows when something's wrong or
            application knows when something's wrong (depending if you
            block or not when the limit is exceeded).
Caching: approximate values, sysadmin is not notified (unless something
         like ioctl/second is available somewhere), application is not
         notified.

[ Whoa, I can't type at the speed of this thread 8-) ]

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

