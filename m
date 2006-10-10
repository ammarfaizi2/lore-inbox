Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWJJNbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWJJNbo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 09:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWJJNbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 09:31:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49884 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750761AbWJJNbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 09:31:43 -0400
Date: Tue, 10 Oct 2006 14:31:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, notting@redhat.com, akpm@osdl.org,
       torvalds@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Introduce vfs_listxattr
Message-ID: <20061010133141.GB31268@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
	linux-kernel@vger.kernel.org, notting@redhat.com, akpm@osdl.org,
	torvalds@osdl.org, viro@ftp.linux.org.uk,
	linux-fsdevel@vger.kernel.org
References: <20061009201048.GA4707@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009201048.GA4707@filer.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 04:10:48PM -0400, Josef Sipek wrote:
> From: Bill Nottingham <notting@redhat.com>
> 
> This patch moves code out of fs/xattr.c:listxattr into a new function -
> vfs_listxattr. The code for vfs_listxattr was originally submitted by Bill
> Nottingham <notting@redhat.com> to Unionfs.

Looks fine, thanks.  I didn't do it back then because nfsd wasn't using
it, but it's an obvious addition to the vfs_* APIs.

