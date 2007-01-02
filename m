Return-Path: <linux-kernel-owner+w=401wt.eu-S964819AbXABMQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbXABMQ4 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbXABMQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:16:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58822 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964819AbXABMQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:16:55 -0500
Date: Tue, 2 Jan 2007 12:16:53 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] fix data corruption bug in __block_write_full_page()
Message-ID: <20070102121653.GA32640@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org> <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org> <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org> <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org> <20061229121946.GA17837@elte.hu> <20070102112054.GC22657@infradead.org> <20070102120634.GA1760@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070102120634.GA1760@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 01:06:34PM +0100, Ingo Molnar wrote:
> Find it below - it's ontop of the tracer included in 2.6.20-rc2-rt3. 
> it's very ad-hoc, based on Linus' test utility. I can write such a 
> tracer in 30 minutes so i usually throw them away. I literally wrote 
> dozens of tracer variants for specific bugs in the past few years.

Ah, I though this was a general purpose tracer.  Question solved, thanks :)

I was just tired of writing my own special purpose tracers all the time
aswell.

