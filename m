Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264004AbUDOP6U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 11:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbUDOP6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 11:58:19 -0400
Received: from web40608.mail.yahoo.com ([66.218.78.145]:59703 "HELO
	web40608.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264004AbUDOP6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 11:58:17 -0400
Message-ID: <20040415155816.47730.qmail@web40608.mail.yahoo.com>
Date: Thu, 15 Apr 2004 17:58:16 +0200 (CEST)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Re: multithreaded coredump in 2.6
To: Sergey Lapin <slapin@caseta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <81C5E83694ADD211ACB50000C02F79D703B735D9@eagle.caseta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Sergey Lapin <slapin@caseta.com> a écrit : > Hi,
> 
> I have run into problem of getting multithreaded coredumps.
> All I am getting
> is core file which under gdb shows only one thread out of my
> around 300
> threads.
> 
> 
> What's wrong? Am I missing something? May be I should change
> some 
> kernel settings to enable kernel dump all threads?
> 

AFAIK the default name of the core file is core. So if you have
300 threads they could overwrite the file to one another.
You can customize the core file naming:
/proc/sys/kernel/core_pattern

see Documentation/sysctl/kernel.txt in your kernel tree

> I will appreciate any help.
> Thanks,
> Sergey Lapin
> -

Calin

=====
--
A mouse is a device used to point at 
the xterm you want to type in.
Kim Alm on a.s.r.


	

	
		
Yahoo! Mail : votre e-mail personnel et gratuit qui vous suit partout ! 
Créez votre Yahoo! Mail sur http://fr.benefits.yahoo.com/

Dialoguez en direct avec vos amis grâce à Yahoo! Messenger !Téléchargez Yahoo! Messenger sur http://fr.messenger.yahoo.com
