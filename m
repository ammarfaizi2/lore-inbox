Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWHQFEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWHQFEi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 01:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWHQFEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 01:04:38 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42473 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932403AbWHQFEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 01:04:37 -0400
From: Neil Brown <neilb@suse.de>
To: Roger Heflin <rheflin@atipa.com>
Date: Thu, 17 Aug 2006 15:04:29 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17635.63709.848914.895135@cse.unsw.edu.au>
Cc: Willy Tarreau <w@1wt.eu>, Xin Zhao <uszhaoxin@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: What's the NFS OOM problem?
In-Reply-To: message from Roger Heflin on Tuesday August 15
References: <4ae3c140608081524u4666fb7x741734908c35cfe6@mail.gmail.com>
	<20060810045711.GI8776@1wt.eu>
	<17627.53340.43470.60811@cse.unsw.edu.au>
	<44E21166.60308@atipa.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 15, rheflin@atipa.com wrote:
> 
> I have noticed on SLES kernels that when the dirty_*ratios turned down it
> still uses alot more memory than it should work writeback buffers, it makes
> me think that with the default setting of 40% that it for some reason
> may be using all of memory and deadlocking.   It does not seem like an
> NFS only issue, as I believe I have duplicated it with a fast lock
> setup.

We seem to have a little patch in SuSE kernels that might be making
the problem worse .... though I presume it was introduced for a
reason.  I haven't managed to track what that reason was yet.

What is "a fast lock setup"??  I don't understand.

NeilBrown
