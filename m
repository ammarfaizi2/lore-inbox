Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311344AbSCLVBe>; Tue, 12 Mar 2002 16:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311345AbSCLVBZ>; Tue, 12 Mar 2002 16:01:25 -0500
Received: from zeus.kernel.org ([204.152.189.113]:31925 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S311344AbSCLVBM>;
	Tue, 12 Mar 2002 16:01:12 -0500
Date: Tue, 12 Mar 2002 21:55:57 +0100
From: Dave Jones <davej@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: strange dmesg output on athlon notebook
Message-ID: <20020312215557.C30825@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Pavel Machek <pavel@suse.cz>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020310220056.GA189@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020310220056.GA189@elf.ucw.cz>; from pavel@suse.cz on Sun, Mar 10, 2002 at 11:00:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2002 at 11:00:57PM +0100, Pavel Machek wrote:
 > Intel machine check reporting enabled on CPU#0.
 > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 > Why _Intel_ machine check?
 
 Same reason the Athlon has Intel style MTRRs.
 Though digging through the docs the last day or so, the MCE isn't
 100% compatable. I'll work on this sometime soon.

 > And why it says  CPU: After vendor init
 > twice? [This is 2.5.6-acpi...]

 SMP kernel ? 
 We init the boot CPU twice on SMP iirc.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
