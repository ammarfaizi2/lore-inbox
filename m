Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbVIAPGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbVIAPGD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbVIAPFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:05:33 -0400
Received: from [81.2.110.250] ([81.2.110.250]:19607 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030184AbVIAPFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:05:04 -0400
Subject: Re: GFS, what's remaining
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, David Teigland <teigland@redhat.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
In-Reply-To: <20050901142708.GA24933@infradead.org>
References: <20050901104620.GA22482@redhat.com>
	 <20050901035939.435768f3.akpm@osdl.org>
	 <1125586158.15768.42.camel@localhost.localdomain>
	 <20050901142708.GA24933@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Sep 2005 16:28:30 +0100
Message-Id: <1125588511.15768.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's GFS.  The submission is about a GFS2 that's on-disk incompatible
> to GFS.

Just like say reiserfs3 and reiserfs4 or ext and ext2 or ext2 and ext3
then. I think the main point still stands - we have always taken
multiple file systems on board and we have benefitted enormously from
having the competition between them instead of a dictat from the kernel
kremlin that 'foofs is the one true way'

Competition will decide if OCFS or GFS is better, or indeed if someone
comes along with another contender that is better still. And competition
will probably get the answer right.

The only thing that is important is we don't end up with each cluster fs
wanting different core VFS interfaces added.

Alan

