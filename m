Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVAYPjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVAYPjB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 10:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVAYPjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 10:39:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3028 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261988AbVAYPig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 10:38:36 -0500
Subject: Re: journaled filesystems -- known instability; Was: XFS:
	inode	with st_mode == 0
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jakob Oestergaard <jakob@unthought.net>,
       Christoph Hellwig <hch@infradead.org>,
       David Greaves <david@dgreaves.com>, Jan Kasprzak <kas@fi.muni.cz>,
       linux-kernel <linux-kernel@vger.kernel.org>, kruty@fi.muni.cz,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <41F6613F.6030509@mnsu.edu>
References: <20041209125918.GO9994@fi.muni.cz>
	 <20041209135322.GK347@unthought.net> <20041209215414.GA21503@infradead.org>
		 <20041221184304.GF16913@fi.muni.cz> <20041222084158.GG347@unthought.net>
	 <20041222182344.GB14586@infradead.org> <41E80C1F.3070905@dgreaves.com>
	 <20050114182308.GE347@unthought.net> <20050116135112.GA24814@infradead.org>
	 <20050117100746.GI347@unthought.net>  <41EC2ECF.6010701@mnsu.edu>
	 <1106657254.1985.294.camel@sisko.sctweedie.blueyonder.co.uk>
	 <41F6613F.6030509@mnsu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106667472.1985.644.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 25 Jan 2005 15:37:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2005-01-25 at 15:09, Jeffrey Hundstad wrote:

> >>  Bad things happening to journaled filesystem machines
> >>  Oops in kjournald

> I wonder if there are several problems.  Alan Cox claimed that there was 
> a fix in linux-2.6.10-ac10 that might alleviate the problem.

I'm not sure --- there are a couple of bio/bh-related fixes in that
patch, but nothing against jbd/ext3 itself. 

> Does linux-2.6.11-rc2 have both the linux-2.6.10-ac10 fix and the xattr 
> problem fixed?

Not sure about how much of -ac went in, but it has the xattr fix.

--Stephen

