Return-Path: <linux-kernel-owner+willy=40w.ods.org-S272613AbVBESoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272613AbVBESoq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 13:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272590AbVBESoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 13:44:39 -0500
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:7955 "EHLO
	smtp-vbr6.xs4all.nl") by vger.kernel.org with ESMTP id S273128AbVBESoA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 13:44:00 -0500
Date: Sat, 5 Feb 2005 19:43:50 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm1
Message-ID: <20050205184350.GA25795@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20050204103350.241a907a.akpm@osdl.org> <20050205181018.GA7278@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205181018.GA7278@ime.usp.br>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rog?rio Brito <rbrito@ime.usp.br>
Date: Sat, Feb 05, 2005 at 04:10:18PM -0200
> 
> I'm having problems when trying to get 2.6.11-rc3-mm1 compiled. The build
> breaks with the message being thrown:
> 
> Inconsistent kallsyms data
> Try setting CONFIG_KALLSYMS_EXTRA_PASS
> make[1]: *** [vmlinux] Error 1
> make[1]: Leaving directory `/usr/local/media/progs/linux/kernel/linux'
> make: *** [stamp-build] Error 2
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> 
> # General setup
> #
> CONFIG_EMBEDDED=y
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_ALL is not set
> # CONFIG_KALLSYMS_EXTRA_PASS is not set

Read what it says, and enable CONFIG_KALLSYMS_EXTRA_PASS, then try
again.

Good luck,
Jurriaan
-- 
I believe in coincidence. Coincidences happen every day. But I don't
trust coincidences.
	Garak - DS9
Debian (Unstable) GNU/Linux 2.6.11-rc3-mm1 2x6078 bogomips load 0.66
