Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317278AbSFCFfk>; Mon, 3 Jun 2002 01:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317279AbSFCFfj>; Mon, 3 Jun 2002 01:35:39 -0400
Received: from holomorphy.com ([66.224.33.161]:33955 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317278AbSFCFfi>;
	Mon, 3 Jun 2002 01:35:38 -0400
Date: Sun, 2 Jun 2002 22:35:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: forget_pte()
Message-ID: <20020603053515.GO10243@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <20020601164002.GC10243@holomorphy.com> <E17Ei8Z-0003Mq-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 01:04:03PM +1000, Rusty Russell wrote:
> Hmm... it's only used in two places, and the name is entirely
> misleading.  I think it might be neater to replace those two
> occurances with:
> 
> 	/* PTEs must be unmapped */
> 	BUG_ON(!pte_none(pte));
> Cheers,
> Rusty.

I'll send a patch replacing it with that open-coded at the call sites
in short order, then.
