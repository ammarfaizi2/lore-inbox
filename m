Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292973AbSBVTsx>; Fri, 22 Feb 2002 14:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292974AbSBVTsi>; Fri, 22 Feb 2002 14:48:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39942 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292970AbSBVTrl>; Fri, 22 Feb 2002 14:47:41 -0500
Subject: Re: 2.4.17: oops in kapm-idled?   (on IBM Thinkpad A30P [2653-66U])
To: beh@icemark.net (Benedikt Heinen)
Date: Fri, 22 Feb 2002 20:01:27 +0000 (GMT)
Cc: jdthood@mail.com (Thomas Hood), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202222029550.1126-100000@berenium.icemark.ch> from "Benedikt Heinen" at Feb 22, 2002 08:34:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16eLsl-0002w4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	snd-*		-> ALSA 0.9.0beta9
> 	e100		-> EtherExpress Pro driver from Intel,
> 			   compiled from the debian e100-source package
> 	xsvc		-> Summit (Accelerated X) driver
> 			   The problem also occurs without it;
> 			   Just trying Accelerated X since I can't get
> 			   agpgart+XFree86+DRI to run...  agpgart fails
> 			   on modprobe... :/
> 	vmnet/vmmon	-> VMware 3.0
> 	pcmcia stuff	-> pcmcia-cs-3.1.31

Is there a reason for using all this non standard stuff. Can you reproduce
the problem if you don't load ALSA (I dont think alsa is prime candidate
here) and you've never loaded either vmware or xsvc or the non kernel 
pcmcia since boot ?

Obviously try with a few of them out and see - I've seen several vmware with
new apm code interactions for one , although none of the others were oopses
