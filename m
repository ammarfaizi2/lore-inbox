Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263127AbRFCOnH>; Sun, 3 Jun 2001 10:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262930AbRFCMkK>; Sun, 3 Jun 2001 08:40:10 -0400
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:45535 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S262901AbRFCMJG>; Sun, 3 Jun 2001 08:09:06 -0400
Date: Sun, 3 Jun 2001 14:09:01 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: jamal <hadi@cyberus.ca>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (forrealthis
In-Reply-To: <Pine.GSO.4.30.0106011357000.11540-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.33.0106031401050.31050-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Jun 2001, jamal wrote:

> Still, the tx watchdogs are a good source of fault detection in the case
> of non-availabilty of MII detection and even with the presence of MII.

Agreed. But my question was a bit different: is there any legit situation
where Tx timeouts can happen in a row _without_ having a link loss ? In
this situation, we'd have false positives...

> "Dynamic" in the above sense means trying to totaly avoid making it a
> synchronous poll. The poll rate is a function of how many packets go out
> that device per average measurement time. Basically, the period that the
> user space app dumps "hello" netlink packets to the kernel is a variable.

Sounds nice, but could this be implemented light enough ?

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

