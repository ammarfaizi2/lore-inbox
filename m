Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269262AbUICOGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269262AbUICOGX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 10:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269706AbUICOCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 10:02:46 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:42245 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269704AbUICOBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 10:01:14 -0400
Date: Fri, 3 Sep 2004 15:01:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
       umbrella-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Umbrella-devel] Re: Getting full path from dentry in LSM hooks
Message-ID: <20040903150111.A4884@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>,
	umbrella-devel@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41385FA5.806@cs.aau.dk> <20040903133238.A4145@infradead.org> <413865B4.7080208@cs.aau.dk> <20040903140449.A4253@infradead.org> <41386FB7.2060804@cs.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41386FB7.2060804@cs.aau.dk>; from ks@cs.aau.dk on Fri, Sep 03, 2004 at 03:20:55PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 03:20:55PM +0200, Kristian Sørensen wrote:
> But we do not have a struct file - just an inode or a dentry :((

Then you can't generate a full path.

> We are working on a project called Umbrella, (umbrella.sf.net) which 
> implements processbased mandatory accesscontrol in the Linux kernel. 
> This access control is controlled by "restriction", e.g. by restricting 
>   some process from accessing any given file or directory.
> 
> E.g. if a root owned process is restricted from accessing /var/www, and 
> the process is compromised by an attacker, no mater what he does, he 
> would not be able to access this directory.

mount --bind /var/www /home/joe/p0rn/, and then?

