Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268971AbUHULGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268971AbUHULGr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 07:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268970AbUHULGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 07:06:47 -0400
Received: from AGrenoble-152-1-16-117.w82-122.abo.wanadoo.fr ([82.122.14.117]:2946
	"EHLO awak.dyndns.org") by vger.kernel.org with ESMTP
	id S268972AbUHULGR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 07:06:17 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Xavier Bestel <xavier.bestel@free.fr>
To: David Greaves <david@dgreaves.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, fsteiner-mail@bio.ifi.lmu.de,
       kernel@wildsau.enemy.org, diablod3@gmail.com,
       B.Zolnierkiewicz@elka.pw.edu.pl
In-Reply-To: <4126F27B.9010107@dgreaves.com>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
	 <4124BA10.6060602@bio.ifi.lmu.de>
	 <1092925942.28353.5.camel@localhost.localdomain>
	 <200408191800.56581.bzolnier@elka.pw.edu.pl>
	 <4124D042.nail85A1E3BQ6@burner>
	 <1092938348.28370.19.camel@localhost.localdomain>
	 <4125FFA2.nail8LD61HFT4@burner>
	 <101FDDA2-F2F5-11D8-8DEC-000393ACC76E@mac.com>
	 <4126F27B.9010107@dgreaves.com>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1093086364.7421.16.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 21 Aug 2004 13:06:05 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam 21/08/2004 à 08:58, David Greaves a écrit :

> Can someone explain why it isn't anyone with _write_ access to the device?
> Surely it's better to drop a user into a group or setgid a program?
> 
> If I have write access to a device then I can wipe it's media anyway.
> Is there something I'm missing?

If you have write access to a single partition only, you could always
screw the entire disk (and with firmware upload, it's really totally
screwed).

	Xav

