Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130205AbRCCAyn>; Fri, 2 Mar 2001 19:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130202AbRCCAyd>; Fri, 2 Mar 2001 19:54:33 -0500
Received: from obelix.plusnet.ch ([194.158.230.8]:40202 "EHLO
	obelix.spectraweb.ch") by vger.kernel.org with ESMTP
	id <S130201AbRCCAyW>; Fri, 2 Mar 2001 19:54:22 -0500
Message-ID: <3AA040C4.3659B274@ulima.unil.ch>
Date: Sat, 03 Mar 2001 01:54:28 +0100
From: Favre Gregoire <greg@ulima.unil.ch>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IRQ advice (2.4.2-ac7)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

as I boot some times under windows, i have to change my IRQ for my PCI
devices to (all) 9... and all the times I tried to boot that way under linux,
it doesn't boot...

So I haven't tested it that way for ages... and now with 2.4.2-ac7 i booted
without any problem that way:
cat /proc/interrupts                                                     03.03 1:52
           CPU0       
  0:    3051534          XT-PIC  timer
  1:      37390          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:    6193814          XT-PIC  HiSax, aic7xxx, EMU10K1, usb-uhci, saa7146(1), bttv
 12:     314048          XT-PIC  PS/2 Mouse
 14:      11820          XT-PIC  ide0
 15:      42041          XT-PIC  ide1
NMI:      27599 
LOC:    3051630 
ERR:          0
MIS:          0

Is it safe to do it that way?

Thanks you very much,

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
