Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262913AbVAQWna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbVAQWna (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262950AbVAQWYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:24:02 -0500
Received: from [81.2.110.250] ([81.2.110.250]:7818 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S262894AbVAQV7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:59:04 -0500
Subject: Re: journaled filesystems -- known instability; Was: XFS: inode
	with st_mode == 0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
Cc: Jakob Oestergaard <jakob@unthought.net>,
       Christoph Hellwig <hch@infradead.org>,
       David Greaves <david@dgreaves.com>, Jan Kasprzak <kas@fi.muni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kruty@fi.muni.cz
In-Reply-To: <41EC2ECF.6010701@mnsu.edu>
References: <20041209125918.GO9994@fi.muni.cz>
	 <20041209135322.GK347@unthought.net> <20041209215414.GA21503@infradead.org>
	 <20041221184304.GF16913@fi.muni.cz> <20041222084158.GG347@unthought.net>
	 <20041222182344.GB14586@infradead.org> <41E80C1F.3070905@dgreaves.com>
	 <20050114182308.GE347@unthought.net> <20050116135112.GA24814@infradead.org>
	 <20050117100746.GI347@unthought.net>  <41EC2ECF.6010701@mnsu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105995240.16119.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 17 Jan 2005 20:54:01 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-17 at 21:31, Jeffrey Hundstad wrote:
> I also can't keep a recent 2.6 or 2.6*-ac* kernel up more than a few 
> hours on a machine under real load.   Perhaps us folks with the problem 
> need to talk to the powers who be to come up with a strategy to make a 
> report they can use.  My guess is we're not sending something that can 
> be used.

I need a way to reproduce it. Preferably on a hardware configuration
that is running 2.6.10-ac10 or later because of the bio and acpi fixes.
I'm not interested in any report including binary drivers and to be
honest the least complex configuration the better. I also care that the
hardware passes memtest86+ !

I also don't care about XFS although Christoph may well do.

Alan

