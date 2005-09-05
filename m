Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbVIEVH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbVIEVH1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbVIEVH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:07:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25360 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932540AbVIEVH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:07:27 -0400
Date: Mon, 5 Sep 2005 22:07:23 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel status, 5 Sep 2005 (empty patches and fixed bugs)
Message-ID: <20050905220722.C938@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050905135546.7732ec27.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050905135546.7732ec27.akpm@osdl.org>; from akpm@osdl.org on Mon, Sep 05, 2005 at 01:55:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 01:55:46PM -0700, Andrew Morton wrote:
> Status of subsystem trees
> -------------------------
> 
>     (size in bytes)
>     96                     git-arm.patch
>     100                    git-arm-smp.patch

I know there's some outstanding in git-arm (I've just sent Linus another
pull request) but according to my pending status here, there's nothing
pending for git-arm-smp.

>     96                     git-mmc.patch
>     99                     git-serial.patch
>     96                     git-ucb.patch

Also all merged and containing nothing.

I suspect you have your own headers in these patches which cause them
to always be non-zero in size.  How about omitting them if they don't
contain a patch?

> [Bugme-new] [Bug 5012] New: moxa tty driver name is wrong and
> 	http://bugzilla.kernel.org/show_bug.cgi?id=5012

Fix merged and closed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
