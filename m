Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264201AbTKKCJx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 21:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbTKKCJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 21:09:52 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:14561 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S264201AbTKKCJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 21:09:50 -0500
From: "Joseph Shamash" <info@avistor.com>
To: "Peter Chubb" <peter@chubb.wattle.id.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2 TB partition support
Date: Mon, 10 Nov 2003 18:12:06 -0800
Message-ID: <HBEHKOEIIJKNLNAMLGAOIECPDKAA.info@avistor.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <16304.9647.994684.804486@wombat.chubb.wattle.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

Forgive another quick Q or two.

What is the maximum partition size for a patched 2.4.x kernel,
and where are those patches?

Thanks,
Joe

-----Original Message-----
From: Peter Chubb [mailto:peterc@chubb.wattle.id.au]On Behalf Of Peter
Chubb
Sent: Monday, November 10, 2003 3:57 PM
To: Joseph Shamash
Cc: linux-kernel@vger.kernel.org
Subject: 2 TB partition support


>>>>> "Joseph" == Joseph Shamash <info@avistor.com> writes:

Joseph> Hello,

Joseph> I'm wondering if I can create a 2 TB partition using linux
Joseph> systems. If so, do I need any special patches?

Yes you can do it.

You need a 2.6 kernel.  And it's best to use something other than the
MSDOS partition format --- I suggest you use parted to create a GPT
partition table (which means compiling your kernel to understand that
format).

You didn't say what architecture you're running on.  If it's a 64-bit
system you don't have to do anything else.  If it's a 32-bit system,
then turn on CONFIG_LBD when you compile.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*



