Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWEJOwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWEJOwU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 10:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWEJOwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 10:52:20 -0400
Received: from [63.81.120.158] ([63.81.120.158]:62592 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751461AbWEJOwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 10:52:20 -0400
Subject: Re: [PATCH -mm] xfs gcc 4.1 warning fixes
From: Daniel Walker <dwalker@mvista.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060510082746.GC18947@infradead.org>
References: <200605100256.k4A2u8ho031797@dwalker1.mvista.com>
	 <20060510082746.GC18947@infradead.org>
Content-Type: text/plain
Date: Wed, 10 May 2006 07:52:17 -0700
Message-Id: <1147272738.21536.84.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 09:27 +0100, Christoph Hellwig wrote:
> On Tue, May 09, 2006 at 07:56:08PM -0700, Daniel Walker wrote:
> > Fixes the following warnings,
> > 
> > fs/xfs/xfs_dir.c: In function 'xfs_dir_removename':
> > fs/xfs/xfs_dir.c:363: warning: 'totallen' may be used uninitialized in this function
> > fs/xfs/xfs_dir.c:363: warning: 'count' may be used uninitialized in this function
> > 
> 
> and so on.  that's all false positives.  gcc should be fixed here, not xfs.

Since it's just a warning , I wouldn't say "false positives" .. The code
is certainly all safe, and the code review didn't hurt XFS at all ..

Daniel

