Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTKHCzi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 21:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTKHCzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 21:55:38 -0500
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:11100 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S261506AbTKHCzg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 21:55:36 -0500
Message-ID: <3FAC675F.8050606@rackable.com>
Date: Fri, 07 Nov 2003 19:47:43 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: CPU-Test similar to Memtest?
References: <20031028160550.GA855@rdlg.net> <1067379433.6281.575.camel@tubarao> <bogc7p$l07$1@gatekeeper.tmr.com>
In-Reply-To: <bogc7p$l07$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2003 02:55:35.0751 (UTC) FILETIME=[C86F8570:01C3A5A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bill davidsen wrote:
> In article <1067379433.6281.575.camel@tubarao>,
> Thayne Harbaugh  <tharbaugh@lnxi.com> wrote:
> 
> | On Tue, 2003-10-28 at 09:05, Robert L. Harris wrote:
> | > I'm going to run MEMTEST today when I get home and get a chance to make
> | > a bootable CD
> | 
> | Memtest86 is good, but it isn't as good as it could be.  Many times I
> | have seen it run 24 hours without error even though the the system has
> | bad memory.
> | 
> | >  but I'm wondering if there might be a "CPUTEST" or such
> | > utility anyone knows of that'll poke and prod a dual athalon real well
> | > and make sure I don't have a flaky cpu.
> | 
> | Run Linpack (or other computationally intensive program) while
> | monitoring ECC errors with either
> | http://www.anime.net/~goemon/linux-ecc/files/
> | or
> | ftp://ftp.lnxi.com/pub/bluesmoke
> 
> I agree with almost everything you said, but I have seen cases in which
> no CPU use would generate an error, but using heavy DMA io in addition
> triggered the problem. If all else fails add your favorite disk test.


   Cpuburn is a good test to run on x86's.  That said I've only seen it 
fail in 2 systems out of ~20,000.  Generally cpu erros will crash your 
system before the error is printed to the screen.

   Also compiling your kernel in a loop is a good way to shake loose 
cpu, and memory issue.  I've often found this finds errors much quicker 
many memory tests.

   You might want to try ctcs.  "Make ; "./new-burn -t"
http://sourceforge.net/projects/va-ctcs/
-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

