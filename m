Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263929AbRFEJIJ>; Tue, 5 Jun 2001 05:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263930AbRFEJH7>; Tue, 5 Jun 2001 05:07:59 -0400
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:33928 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S263929AbRFEJHo>; Tue, 5 Jun 2001 05:07:44 -0400
Date: Tue, 5 Jun 2001 11:07:06 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Frazer <mark@somanetworks.com>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>, <saw@saw.sw.com.sg>
Subject: Re: MII access (was [PATCH] support for Cobalt Networks (x86 only)
In-Reply-To: <3B1A2982.C53B159C@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0106051104140.5137-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jun 2001, Jeff Garzik wrote:

> Bogdan Costescu wrote:
> > With clearer mind, I have to make some a correction to one of the previous
> > messages: the problem of not checking arguments range does not apply to
> > 3c59x which has in the ioctl function '& 0x1f' for both transceiver number
> > and register number. However, eepro100 and tulip don't do that. (I'm
> > checking now with 2.4.3 from Mandrake 8, but I don't think that there were
> > recent changes in these areas).
>
> half right -- tulip does this for the phy id but not the MII register
> number.  I'll fix that up.  Please bug Andrey about fixing up
> eepro100...

OK, Andrey is now CC-ed. However, I only checked the 3 mentioned drivers,
while MII ioctl's are used in many more... I was hoping that the
mantainers would jump in!

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

