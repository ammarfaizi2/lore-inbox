Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280933AbRKGTdH>; Wed, 7 Nov 2001 14:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280939AbRKGTc6>; Wed, 7 Nov 2001 14:32:58 -0500
Received: from urdvg135.cms.usa.net ([204.68.25.135]:4556 "HELO
	urdvg135.cms.usa.net") by vger.kernel.org with SMTP
	id <S280933AbRKGTcl> convert rfc822-to-8bit; Wed, 7 Nov 2001 14:32:41 -0500
Message-ID: <20011107193235.18379.qmail@cpdvg202.cms.usa.net>
Date: 7 Nov 2001 13:32:35 CST
From: Eric Bresie <ebresie@usa.net>
To: linux-kernel@vger.kernel.org
Subject: Probing for Kernel Configuration
X-Mailer: USANET web-mailer (34FM.0700.21.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just recently installed a new version of Redhat 7.2 and had problems with
some of my devices not being supported as part of the stock
installation...this got me thinking...I noticed that when I did a lspci that a
majority of my hardware was identified, but there was no guarantee that the
module to support that hardware is present in the kernel or configured..

Is it possible prior to kernel configuration to perhaps have something like a
make newconfig or make probe-config to probe the system and give a guess as to
what modules are needed for a given system...I guess you could think of it
kind of as a plug-n-play for kernel configuration.

I could see how this might require some mapping of hardware probed information
to kernel config options which would then enable them (and if appropriate set
to current settings).  And also might require some default utilities like the
pci utilities, the usb utilities, scsi, etc...

Any comments?

Eric Bresie
ebresie@usa.net
