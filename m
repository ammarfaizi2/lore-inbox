Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266731AbSLPN2o>; Mon, 16 Dec 2002 08:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266733AbSLPN2o>; Mon, 16 Dec 2002 08:28:44 -0500
Received: from smtp-server3.tampabay.rr.com ([65.32.1.41]:54430 "EHLO
	smtp-server3.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S266731AbSLPN2n>; Mon, 16 Dec 2002 08:28:43 -0500
From: "Scott Robert Ladd" <scott@coyotegulch.com>
To: "Zwane Mwaikambo" <zwane@holomorphy.com>
Cc: "Robert Love" <rml@tech9.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: re: /proc/cpuinfo and hyperthreading
Date: Mon, 16 Dec 2002 08:38:05 -0500
Message-ID: <FKEAJLBKJCGBDJJIPJLJEEKMDLAA.scott@coyotegulch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.50.0212160133300.12535-100000@montezuma.mastecende.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> It's ok.

I'm not so sure.

To get the most benefit from two logical CPUs, don't I need the kernel to
operate as a 2-CPU SMP system?

Windows XP initializes the system as SMP with two CPUs; when I run an OpenMP
application under Windows, it reports two CPUs and a maximum of two threads.
Under Linux,

Linux SMP should initialize based on the number of logical CPUS, not the
physical number of ships; thus, I should be seeing two CPUs in
/proc/cpuinfo, not one.

..Scott

