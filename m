Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290110AbSAKVMW>; Fri, 11 Jan 2002 16:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290113AbSAKVMM>; Fri, 11 Jan 2002 16:12:12 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:20137 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S290110AbSAKVMA>; Fri, 11 Jan 2002 16:12:00 -0500
Date: Fri, 11 Jan 2002 16:13:00 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020111144117.A1485@asooo.flowerfire.com>
Message-ID: <Pine.LNX.4.33.0201111609340.2580-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> overall performance seems far lower.  For instance, without the patch
> the -j build finishes in ~10 minutes (2x933P3/256MB) but with the patch

please, PLEASE stop using "make -j" 
for anything except the fork-bomb that it is.
pretending that it's a benchmark, especially one 
to guide kernel tuning, is a travesty!

if you want to simulate VM load, so something sane like
boot with mem=32M, or a simple "mmap(lots); mlockall" tool.

regards, mark hahn.

