Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270682AbRHJXRU>; Fri, 10 Aug 2001 19:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270684AbRHJXRK>; Fri, 10 Aug 2001 19:17:10 -0400
Received: from star.atlas-iap.es ([194.224.1.2]:18448 "EHLO star.atlas-iap.es")
	by vger.kernel.org with ESMTP id <S270682AbRHJXRA>;
	Fri, 10 Aug 2001 19:17:00 -0400
From: "Ricardo Galli" <gallir@uib.es>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Remotely rebooting a machine with state 'D' processes, how?
Date: Sat, 11 Aug 2001 01:25:33 +0200
Message-ID: <LOEGIBFACGNBNCDJMJMOEEEICNAA.gallir@uib.es>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >man 2 reboot
> > How do you do this when the process in the D state is holding the BKL?
> 
> OK. What about console_lock since reboot(2) insists on doing a printk?

reboot -n -f ?

--ricardo
http://m3d.uib.es/~gallir/ 
