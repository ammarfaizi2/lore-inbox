Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751499AbWDBWvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbWDBWvP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 18:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWDBWvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 18:51:15 -0400
Received: from web30606.mail.mud.yahoo.com ([68.142.200.129]:44708 "HELO
	web30606.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751499AbWDBWvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 18:51:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=2FP7i6xFCOUvvQPJfOzhKoRfwpRgME3aa6LciSqx2+79rZffFvJK6lFrfUmGPwyISlPlskoYm5FiE2Mr1fDPdXQqty+Ywt6LiQUh2OBlJuaUU4B0SNMEsyZEm/UW/Sg3x2kGX71lmB3VLEkE1eM8aJPOpSK4c+7SGVn25GZi+Lg=  ;
Message-ID: <20060402225112.4629.qmail@web30606.mail.mud.yahoo.com>
Date: Mon, 3 Apr 2006 00:51:12 +0200 (CEST)
From: zine el abidine Hamid <zine46@yahoo.fr>
Subject: Re: Detecting I/O error and Halting System
To: Bernd Eckenfels <be-news06@lina.inka.de>, linux-kernel@vger.kernel.org
In-Reply-To: <E1FOwGQ-00034J-00@calista.inka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


watchdog isn't helpfull because some parts of the
drives (some directories, and some command) seems to
be accessible and most aren't. But I think that the
files that seems to be readable are on the cache.


--- Bernd Eckenfels <be-news06@lina.inka.de> a écrit :

> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > See the softdog driver for an example.
> 
> The usermode agent (watchdog(8) can, btw monitor the
> availableness of a
> file, no need to write a module. MAybe this feature
> was added after somebody
> took that code over from you? :)
> 
> watchdog.conf(5) says: 
> 
> #     file = <filename> Set file name for file mode.
>  This option can be
> #              given as often as you like to check
> several files.
> 
> Bernd
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



	

	
		
___________________________________________________________________________ 
Nouveau : téléphonez moins cher avec Yahoo! Messenger ! Découvez les tarifs exceptionnels pour appeler la France et l'international.
Téléchargez sur http://fr.messenger.yahoo.com
