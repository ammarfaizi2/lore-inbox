Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWGQKkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWGQKkx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 06:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWGQKkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 06:40:53 -0400
Received: from sandesha.sasken.com ([164.164.56.19]:49643 "EHLO
	mail3.sasken.com") by vger.kernel.org with ESMTP id S1750716AbWGQKkw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 06:40:52 -0400
Date: Mon, 17 Jul 2006 16:10:41 +0530 (IST)
From: Subbu <subbu@sasken.com>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
cc: linuxanimesh@rediffmail.com, subbu2k_av@yahoo.com
Subject: Compiling Driver code for 2.6 kernel
In-Reply-To: <Pine.GSO.4.64.0607071626210.2230@sunm21.sasken.com>
Message-ID: <Pine.GSO.4.64.0607171557040.15797@sunm21.sasken.com>
References: <Pine.GSO.4.64.0607071626210.2230@sunm21.sasken.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN;
	charset=US-ASCII;
	format=flowed
X-imss-version: 2.037
X-imss-result: Passed
X-imss-scores: Clean:87.63791 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:3 C:2 M:3 S:3 R:3 (0.5000 0.5000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

   Please Help me as i am newbie to 2.6 kernel.

   I have My driver code for 2.4.20 kernel(Here i generate .o with 100's 
of .objs linked together).

   I have a main GNUMakefile linked with 10's of individual make files 
w.r.t different directories

   i am able to compile my source code and able to link all individual 
modules and generate final module.o (2.6). but i am not sure how to 
genrate .ko from the module.o i have.

   I understand the compilation for 2.6 is different.

   How i can generate .ko which is required for 2.6.

  1) Is a simple Makefile changes for 2.4 to 2.6 enough..?? then what needs 
to done in my GNUmakefile(not the kernel source)
  2) Is it required to use kernel source  GNUMakefile as given in examples 
***
  3) Is it o.k to compile individual 'c' files with .obj and linked to 
module.o

  Please help me in this regards

THanx in advance
Subbu


"SASKEN RATED Among THE Top 3 BEST COMPANIES TO WORK FOR IN INDIA - SURVEY 2005 conducted by the BUSINESS TODAY - Mercer - TNS India"

                           SASKEN BUSINESS DISCLAIMER
This message may contain confidential, proprietary or legally Privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, Disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email
