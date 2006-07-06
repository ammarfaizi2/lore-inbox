Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWGFUq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWGFUq5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWGFUq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:46:56 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:25212 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750841AbWGFUq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:46:56 -0400
Date: Thu, 6 Jul 2006 13:43:29 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org, kurt.hackel@oracle.com,
       ocfs2-devel@oss.oracle.com
Subject: Re: [-mm patch] fs/ocfs2/inode.c:ocfs2_refresh_inode(): remove unused variable
Message-ID: <20060706204329.GD29686@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060703030355.420c7155.akpm@osdl.org> <20060706203708.GQ26941@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706203708.GQ26941@stusta.de>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 10:37:08PM +0200, Adrian Bunk wrote:
> On Mon, Jul 03, 2006 at 03:03:55AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.17-mm5:
> >...
> > +inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default.patch
> >...
> >  Misc updates.
> >...
> 
> This patch removes a no longer used variable.
Ahh, the osb was only used to set i_blksize, which of course the inode-diet
patches removed. Looks fine to me - thanks Adrian.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
