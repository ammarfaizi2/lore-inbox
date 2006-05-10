Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWEJI1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWEJI1v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 04:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWEJI1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 04:27:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32174 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932301AbWEJI1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 04:27:50 -0400
Date: Wed, 10 May 2006 09:27:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] xfs gcc 4.1 warning fixes
Message-ID: <20060510082746.GC18947@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Daniel Walker <dwalker@mvista.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <200605100256.k4A2u8ho031797@dwalker1.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605100256.k4A2u8ho031797@dwalker1.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 07:56:08PM -0700, Daniel Walker wrote:
> Fixes the following warnings,
> 
> fs/xfs/xfs_dir.c: In function 'xfs_dir_removename':
> fs/xfs/xfs_dir.c:363: warning: 'totallen' may be used uninitialized in this function
> fs/xfs/xfs_dir.c:363: warning: 'count' may be used uninitialized in this function
> 

and so on.  that's all false positives.  gcc should be fixed here, not xfs.

