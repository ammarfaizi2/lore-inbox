Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263390AbTDTKYN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 06:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263551AbTDTKYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 06:24:13 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:59275 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S263390AbTDTKYM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 06:24:12 -0400
Message-ID: <20030420103604.27231.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Sun, 20 Apr 2003 18:36:04 +0800
Subject: [ALSA] no sound with Maestro3
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I think I undestood wich is the option that cause the error I reported,
[ ]     OSS Sequencer API
If I enable that option I get the following error
request_module: failed /sbin/modprobe -- snd-card-0. error = -16

Now my dmesg is:
Advanced Linux Sound Architecture Driver Version 0.9.2 (Thu Mar 20 13:31:57 2003 UTC).
PCI: Found IRQ 5 for device 00:0d.0
ALSA device list:
  #0: Dummy 1
  #1: Virtual MIDI Card 1
  #2: ESS Maestro3 PCI at 0x1800, irq 5
  
But I still not able to play _any_ sound, I don't think that it is a problem
with my init scripts because with 2.4 I have _no_ problem.

I've updated the bugzilla's bug report,
http://bugzilla.kernel.org/show_bug.cgi?id=395

Any hint ?

Ciao,
        Paolo


-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
