Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTJZRQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 12:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263344AbTJZRQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 12:16:58 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:36511 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S263343AbTJZRQ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 12:16:56 -0500
Date: Sun, 26 Oct 2003 18:16:50 +0100
From: Marco Roeland <marco.roeland@xs4all.nl>
To: wsy@merl.com
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: compile-time error in 2.6.0-test9
Message-ID: <20031026171650.GD23792@localhost>
References: <200310261553.h9QFrb513039@localhost.localdomain> <20031026162422.GB23792@localhost> <200310261635.h9QGZTe13121@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200310261635.h9QGZTe13121@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 Oktober 2003 at 11:35 uur Bill Yerazunis wrote:

> What's the recommended version of GCC these days?

According to Documentation/Changes the 'bottomline' gcc (at least on
i386) is gcc 2.95.3 but 2.95.4 from Debian or 2.96 from RedHat and
Mandrake should be alright. A problem is that they are no longer
actively maintained so bugs aren't fixed. :-(

Just recently gcc 3.3.2 was released, so that or the latest from one's
distribution is 'current' and should work fine. Be warned though that
although they produce better code (and even that is sometimes disputed!)
and give better warnings, compilation is a lot slower.

The Linux kernel has a lot of handcrafted optimised code, so no gcc
version is going to outsmart that easily anyway, and also very important
is the amount of testing a kernel gets. Better a somewhat less optimal
compiler but which has had a lot of testing, and so has it bugs known
and 'workarounded', than a potential 'flyer' with unknown new bugs.

But for userspace applications I'd recommend gcc 3.x wholeheartedly,
for g++ especially.
-- 
Marco Roeland
