Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWGRLnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWGRLnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 07:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWGRLnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 07:43:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44520 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751298AbWGRLnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 07:43:23 -0400
Date: Tue, 18 Jul 2006 12:43:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>,
       Jeff Anderson-Lee <jonah@eecs.berkeley.edu>,
       "'fsdevel'" <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Reiser4 Inclusion
Message-ID: <20060718114317.GA724@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Dike <jdike@addtoit.com>,
	Erik Mouw <erik@harddisk-recovery.com>,
	Jeff Anderson-Lee <jonah@eecs.berkeley.edu>,
	'fsdevel' <linux-fsdevel@vger.kernel.org>,
	linux-kernel@vger.kernel.org
References: <44BAFDB7.9050203@calebgray.com> <1153128374.3062.10.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0607171242350.10427@alpha.polcom.net> <000001c6a9b3$81186ea0$ce2a2080@eecs.berkeley.edu> <20060717204804.GA18516@harddisk-recovery.com> <20060718004931.GB8092@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060718004931.GB8092@ccure.user-mode-linux.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2006 at 08:49:31PM -0400, Jeff Dike wrote:
> On Mon, Jul 17, 2006 at 10:48:04PM +0200, Erik Mouw wrote:
> > On Mon, Jul 17, 2006 at 08:13:04AM -0700, Jeff Anderson-Lee wrote:
> > > In the past I've wondered why so many experimental FS projects die this
> > > death of obscurity in that they only work under FreeBSD or some ancient
> > > version of Linux.? I'm beginning to see why that is so:? the Linux core
> > > simply changes too fast for it to be a decent FS R&D environment!
> > 
> > That hasn't been a problem for OCFS2 and FUSE (recently merged), and
> > also doesn't seem to be a problem for GFS.
> 
> I'm been maintaining a couple (for now) out-of-tree filesystems for
> UML, and have seen only minor updates needed over the course of 2.6.
> 
> Complaints about interface churn for filesystems (or anything else,
> actually, since an architecture, such as UML, is exposed to nearly the
> entire kernel) are imcomprehensible to me.

Yes, in 2.6 there were very little changes to the filesystem interface.
I count that as a good sign, it means our VFS and common fs helper code
has become pretty mature.
