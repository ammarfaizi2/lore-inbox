Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261783AbTCaSaD>; Mon, 31 Mar 2003 13:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261784AbTCaSaD>; Mon, 31 Mar 2003 13:30:03 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:54034 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261783AbTCaS37>; Mon, 31 Mar 2003 13:29:59 -0500
Date: Mon, 31 Mar 2003 19:41:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 64GB NUMA-Q after pgcl
Message-ID: <20030331194117.A27859@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030328040038.GO1350@holomorphy.com> <20030330231945.GH2318@x30.local> <20030331042729.GQ30140@holomorphy.com> <20030331183506.GC11026@x30.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030331183506.GC11026@x30.random>; from andrea@suse.de on Mon, Mar 31, 2003 at 08:35:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 08:35:06PM +0200, Andrea Arcangeli wrote:
> About you not caring anymore about the mem_map array size, that still
> matters on the embedded usage, infact rmap on the embedded usage is the
> biggest waste there, normally they don't even have swap so if something
> you should use the rmap provided for truncate, rather than wasting
> memory in the mem_map array.

We have CONFIG_SWAP for that in 2.5..

