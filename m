Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317235AbSEXSb5>; Fri, 24 May 2002 14:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317238AbSEXSb4>; Fri, 24 May 2002 14:31:56 -0400
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:14218 "EHLO
	brmx1.fl.icn.siemens.com") by vger.kernel.org with ESMTP
	id <S317235AbSEXSby>; Fri, 24 May 2002 14:31:54 -0400
Message-ID: <180577A42806D61189D30008C7E632E8793902@boca213a.boca.ssc.siemens.com>
From: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
To: linux-kernel@vger.kernel.org
Subject: signal handling
Date: Fri, 24 May 2002 14:31:53 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a rather strange situation. I am running an embedded system using Red
Hat 7.0 (Kernel 2.2-16). It si pretty much a stripped down version. I have
installed my own signal handler in my application for SIGTERM and SIGTSTP
(and a couple of others).  The handler itself is nothing more than a "case
signal of" construct. I always hit the default leg because the signal number
which is passed into my application appears to contain garbage. When a
repeat the same test with a full install it works correctly.

Some background. the application is written using Borland Kylix 2.0. I have
set the compiler options so that the selected signals are handled internally
by the application (i.e. not by the debugger). If anybody has an idea of
what may cause this please CC me directly.

Thanks in advance. 

Jack Bloch
Siemens Carrier Networks
e-mail    : jack.bloch@icn.siemens.com
phone     : (561) 923-6550

