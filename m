Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbVKPP1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbVKPP1Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 10:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbVKPP1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 10:27:24 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:12036 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751471AbVKPP1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 10:27:23 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Jeff V. Merkey" <jmerkey@utah-nac.org>
Cc: <alex@alexfisher.me.uk>, <linux-kernel@vger.kernel.org>
Subject: RE: Would I be violating the GPL?
Date: Wed, 16 Nov 2005 07:26:55 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKIEDBIBAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200511011915.49480.s0348365@sms.ed.ac.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 16 Nov 2005 07:24:17 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 16 Nov 2005 07:24:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If you even take 2 minutes to actually inspect the NVIDIA video
> driver sources
> (extract the .run file with --extract-only, and cd to usr/src/nv)
> you'll find
> the "glue" which is provided as source, but not under the GPL,
> does indeed
> #include kernel headers at compile time.
>
> It does not distribute them, however, but it is completely nonsensical to
> class this as having "no dependency". It has a compile time and runtime
> dependency on the current kernel. What driver wouldn't?

	If I write source code that includes "stdio.h", I can do whatever I want
with that source code, and I'm not bound by the license of any particular
file that happens to be called "stdio.h". On the other hand, if I compile
that source code including *your* "stdio.h" file, the resulting compiled
output is likely a derived work of your file.

	So the source code is not a derivative work of any GPL'd files. The
compiled driver may be, precisely because it contains bits and pieces of the
header files.

	DS


