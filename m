Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265885AbTAOJUT>; Wed, 15 Jan 2003 04:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265895AbTAOJUT>; Wed, 15 Jan 2003 04:20:19 -0500
Received: from albatross-ext.wise.edt.ericsson.se ([193.180.251.49]:23251 "EHLO
	albatross.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S265885AbTAOJUT>; Wed, 15 Jan 2003 04:20:19 -0500
X-Sybari-Trust: 8b89339d 1864f774 206fc897 00000138
From: Miklos.Szeredi@eth.ericsson.se (Miklos Szeredi)
Date: Wed, 15 Jan 2003 10:29:01 +0100 (MET)
Message-Id: <200301150929.h0F9T1I10444@duna48.eth.ericsson.se>
To: linux-kernel@vger.kernel.org
Subject: VIA C3 and random SIGTRAP or segfault
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just bought a VIA C3 866 processor, and under very special
circumstances some programs (e.g. mplayer, xmms) randomly crash with
trace/breakpoint trap or segmentation fault.  Otherwise the system
seems stable even under high load.  Tested under various kernels
(generic i386 2.2.19, 2.4.19, and 2.4.19 compiled for the C3), with
different memory modules (some known to be good) and various video
cards and X servers, but the result is always the same.

Can this be a software fault or is the CPU faulty?  Can anything other
then a CPU fault cause programs to receive SIGTRAP?

The system config is:

cpu: C3 866MHz
mb: asus cuv4x-c (via vt82c694x chipset)

The BIOS recognises the CPU as "VIA Cyrix III 866A", which is not
exactly right but almost.

Any advice is greatly appreciated!
Miklos
