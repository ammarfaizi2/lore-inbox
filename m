Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314289AbSEFI4e>; Mon, 6 May 2002 04:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314291AbSEFI4d>; Mon, 6 May 2002 04:56:33 -0400
Received: from basfegw1.basf-ag.de ([141.6.1.21]:26021 "EHLO
	basfegw1.basf-ag.de") by vger.kernel.org with ESMTP
	id <S314289AbSEFI4a>; Mon, 6 May 2002 04:56:30 -0400
Subject: Review: Servercrash with kernel SuSE 2.4.16
To: chris.mason@suse.com, alessandro.suardi@oracle.com
Cc: sbrand@mainz.ibm.com, reiser@namesys.com, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Version 5.0 (Intl)   14. April 1999
Message-ID: <OF10FE0462.9B5B7937-ONC1256BB1.002ADC0F@bcs.de>
From: Oliver.Schersand@BASF-IT-Services.com
Date: Mon, 6 May 2002 10:57:15 +0200
X-MIMETrack: Serialize by Router on EUROPE-Gw03/EUROPE/BASF(Release 5.0.8 |June 18, 2001) at
 06/05/2002 10:56:11
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the actual result of the analys of our oracle server crashes on
linux servers with suse Enterprise Server 7 and Kernel 2.4.16

The reason for theses crashes where  the compaq remote inside and compaq
health drivers. These drivers are deliverd from compaq. On stardup of these
agents, they load binary kernel modules, which are very version sensitive.
This modules  corrupt the virtual memory management of the server on heavy
load

This shows us a main problem of Linux in datacenter environment. The
automatic guarding of the local attached storage and the hardware is very
importend in this environments. In this environment we use expensive high
performance hardware. These hardware is not  good  supported by the
standard linux kernel. The companies which sell these hardware deliver not
all features of these hardware to the community of linux.  There drivers
and guarding agents are not distributed under GPL.


Here is the statement of Compaq ( HPQ)

   The new health driver that can be run on any re-compiled kernel is due
   out in the SmartStart 5.50 timeframe (3Q02).  The reason for this is
   that it also provides support for new servers as well.
   The delivery method will be via the Compaq web site and the SmartStart
   Cd.

   The customer expectation is that it will work with any re-compiled
   kernel.  Most likely that will be true however it will be impossible for
   us to validate it with every possibility due to the open source nature
   of Linux.

   Today, customers actually can run the existing health driver on
   re-compiled kernels by evoking a "fix-up" script that will be available
   on our website.  This is not an ideal solution but it will work in a
   majority of the situations.


Thank you very much for all the help with this problem

Oliver Schersand

