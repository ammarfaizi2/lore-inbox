Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288050AbSAQBY0>; Wed, 16 Jan 2002 20:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288040AbSAQBYU>; Wed, 16 Jan 2002 20:24:20 -0500
Received: from ns.suse.de ([213.95.15.193]:46341 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288028AbSAQBYD>;
	Wed, 16 Jan 2002 20:24:03 -0500
Date: Thu, 17 Jan 2002 02:23:58 +0100
From: Andi Kleen <ak@suse.de>
To: Wilson Yeung <wilson@whack.org>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: hires timestamps for netif_rx()
Message-ID: <20020117022358.B30053@wotan.suse.de>
In-Reply-To: <20020116180042.A21447@willow.seitz.com> <Pine.GSO.4.40.0201161514030.5375-100000@apogee.whack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.40.0201161514030.5375-100000@apogee.whack.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 03:33:04PM -0800, Wilson Yeung wrote:
> I'd love to have a run-time tuneable kernel parameter that lets me use
> do_gettimeofday() instead of get_fast_time for received packet
> timestamping.  Does this seem reasonable?

Both functions should just access the TSC of your CPU and be equivalent. 

-Andi
