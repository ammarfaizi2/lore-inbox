Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269844AbUJHBdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269844AbUJHBdC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 21:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269820AbUJHBdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 21:33:00 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:28544
	"HELO home.linuxace.com") by vger.kernel.org with SMTP
	id S269844AbUJGWGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:06:46 -0400
Date: Thu, 7 Oct 2004 15:06:40 -0700
From: Phil Oester <kernel@linuxace.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Process start times moving in reverse on 2.6.8.1
Message-ID: <20041007220640.GA18303@linuxace.com>
References: <20041004190054.GA29409@linuxace.com> <20041004163511.5624c52c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041004163511.5624c52c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 04:35:11PM -0700, Andrew Morton wrote:
> Phil Oester <kernel@linuxace.com> wrote:
> > Notice the two minute difference between now and what the
> > process start time is.  Uptime on this box is 48 days, so
> > it is a gradual drift.
> > 
> > Any ideas on this?  Or has it been fixed since 2.6.8.1?
> 
> It's allegedly fixed by
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm2/broken-out/fix-process-start-times.patch
> but I've seen no confirmation of that.

After running a patched 2.6.9-rc3-bk7 box for a day vs a freshly
rebooted 2.6.8.1, I can confirm that process start times seem
to coincide with current time, while the 2.6.8.1 box is already
out of sync.

I'd say this is a keeper, but can track it longer if you prefer.

Phil

