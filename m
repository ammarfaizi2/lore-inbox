Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261510AbTCJVwS>; Mon, 10 Mar 2003 16:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261511AbTCJVwS>; Mon, 10 Mar 2003 16:52:18 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:8459 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261510AbTCJVwP>; Mon, 10 Mar 2003 16:52:15 -0500
Date: Mon, 10 Mar 2003 22:02:33 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Michael Hunold <m.hunold@gmx.de>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v4l: create include/media.
Message-ID: <20030310220233.A13923@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Gerd Knorr <kraxel@bytesex.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Michael Hunold <m.hunold@gmx.de>,
	Kernel List <linux-kernel@vger.kernel.org>
References: <20030310200852.GA6397@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030310200852.GA6397@bytesex.org>; from kraxel@bytesex.org on Mon, Mar 10, 2003 at 09:08:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define MIN(a,b) (((a)>(b))?(b):(a))
> +#define MAX(a,b) (((a)>(b))?(a):(b))

Don't do that.  Use the kernel's min/max instead.

