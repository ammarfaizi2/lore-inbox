Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936387AbWK3M0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936387AbWK3M0F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936411AbWK3M0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:26:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42906 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S936399AbWK3MZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:25:39 -0500
Date: Thu, 30 Nov 2006 12:25:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GFS2] split gfs2_dinode into on-disk and host variants [1/70]
Message-ID: <20061130122538.GA27549@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steven Whitehouse <swhiteho@redhat.com>, cluster-devel@redhat.com,
	linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
References: <1164888743.3752.303.camel@quoit.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164888743.3752.303.camel@quoit.chygwyn.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	struct gfs2_dinode_host *di = &ip->i_di;

Please call this things just gfs2_inode.  gfs_d(isk)_inode_host doesn't
make any sense.

