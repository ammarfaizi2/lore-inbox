Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbTABQ0p>; Thu, 2 Jan 2003 11:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264766AbTABQ0o>; Thu, 2 Jan 2003 11:26:44 -0500
Received: from verein.lst.de ([212.34.181.86]:5394 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S264724AbTABQ0m>;
	Thu, 2 Jan 2003 11:26:42 -0500
Date: Thu, 2 Jan 2003 17:35:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] more procfs bits for !CONFIG_MMU
Message-ID: <20030102173505.B11900@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <20030102000522.A6137@lst.de> <Pine.LNX.4.44.0301011539070.12809-100000@home.transmeta.com> <20030101235842.A3044@infradead.org> <20030102162956.GB956@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030102162956.GB956@mars.ravnborg.org>; from sam@ravnborg.org on Thu, Jan 02, 2003 at 05:29:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 05:29:56PM +0100, Sam Ravnborg wrote:
> New Makefile:
> proc-y             := proc_mmu.o
> proc-$(CONFIG_MMU) := proc_nommu.o
>

Wouldn't this add proc_mmu.o even if CONFIG_MMU is not y?

