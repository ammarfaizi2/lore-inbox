Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUEQWoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUEQWoM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 18:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUEQWoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 18:44:12 -0400
Received: from are.twiddle.net ([64.81.246.98]:14471 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S263001AbUEQWj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 18:39:57 -0400
Date: Mon, 17 May 2004 15:39:37 -0700
From: Richard Henderson <rth@twiddle.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Christoph Hellwig <hch@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org
Subject: Re: alpha fp-emu vs module refcounting
Message-ID: <20040517223937.GA22256@twiddle.net>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Christoph Hellwig <hch@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org
References: <20040507110217.GA11366@lst.de> <20040507183208.A3283@jurassic.park.msu.ru> <20040507143512.GA14338@lst.de> <20040508023717.A3960@jurassic.park.msu.ru> <20040507224104.GA21153@lst.de> <20040508025142.A4330@jurassic.park.msu.ru> <20040516100435.GD16301@infradead.org> <20040516164420.A950@den.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040516164420.A950@den.park.msu.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2004 at 04:44:20PM +0400, Ivan Kokshaysky wrote:
> Yet another simple solution would be just to remove refcounting and
> only allow modular build of math-emu when CONFIG_SMP=n, which is
> safe vs module unload and still fine for debugging.
> 
> Richard?

Seems reasonable.  We've already got it under the debugging
config section, right?


r~
