Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318058AbSHCWdt>; Sat, 3 Aug 2002 18:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318064AbSHCWds>; Sat, 3 Aug 2002 18:33:48 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:58348 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S318058AbSHCWcr>; Sat, 3 Aug 2002 18:32:47 -0400
Message-ID: <20020803223614.13791.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Perry Gilfillan" <perrye@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Sun, 04 Aug 2002 04:36:14 +0600
Subject: i386/kernel/pci-pc.c and tdfxfb.c
X-Originating-Ip: 66.210.167.59
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got two questions, and I'm not sure if they will be related in any way.

My equipment:  I have a Voodoo3 and VIA MVP3/Pro133x AGP and Apollo VP3

The first is that in 2.4.18, arch/i386/kernel/pci-pc.c had pci_fixup for the VIA VT82C597, 598, and 691 bridge chip sets.  

All referenc to the VT82C5xx chips seem to be removed.

If I recall corectly, ( I might not ) on 2.4.18, when I removed the lines from the pcibios_fixups struct, and teh procedures associated with them, it cleared up the corupted boot logo.

The logo is corupted again.

The second, and more critical problem is that if tdfxfb is compiled in or set as a module, all consoles go black on black when X comes up.

I didn't see any refrence to tdfxfb.c in the 2.4.19 patch, and I don't know where else to look.

With tdfxfb out of the picture, the consoles are fine.

If anyone can point me in the right direction, I'm glad to try any sugestions, including patches, to resolve this problem.

Regads,
           Perry Gilfillan

-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
