Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286310AbRLTSHk>; Thu, 20 Dec 2001 13:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286311AbRLTSHR>; Thu, 20 Dec 2001 13:07:17 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:5555 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S286310AbRLTSHQ>; Thu, 20 Dec 2001 13:07:16 -0500
Message-Id: <200112201721.KAA05522@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
To: esr@thyrsus.com
Subject: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
Date: Thu, 20 Dec 2001 11:02:28 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all,

I see that in the very latest Configure.help version, 2.76, available at http://www.tuxedo.org/~esr/cml2/
Eric has decided to follow the following standard:
IEC 60027-2, Second edition, 2000-11, Letter symbols to be used in electrical technology - Part 2: Telecommunications and electronics.
and has changed all the abbreviations for Kilobyte (KB) to KiB, Megabyte (MB) to MiB, etc, etc.

Now, granted that this is the "standard", should there be some discussion related to this
change, or is everyone comfortable with this?  It certainly made me do a double take.

Here is a snippet from the diff between versions 2.75 and 2.76 of Configure.help:

@@ -344,8 +344,8 @@
   If you are compiling a kernel which will never run on a machine with
   more than 960 megabytes of total physical RAM, answer "off" here
   (default choice and suitable for most users). This will result in a
-  "3GB/1GB" split: 3GB are mapped so that each process sees a 3GB
-  virtual memory space and the remaining part of the 4GB virtual memory
+  "3GiB/1GiB" split: 3GiB are mapped so that each process sees a 3GiB
+  virtual memory space and the remaining part of the 4GiB virtual memory
   space is used by the kernel to permanently map as much physical memory
   as possible.

Steven
