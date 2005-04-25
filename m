Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbVDYUHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbVDYUHM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbVDYUHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:07:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64930 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262766AbVDYUHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:07:08 -0400
Date: Mon, 25 Apr 2005 21:07:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Colin Leroy <colin@colino.net>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] hfsplus: don't oops on bad FS
Message-ID: <20050425200704.GA16093@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Colin Leroy <colin@colino.net>,
	Roman Zippel <zippel@linux-m68k.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20050425211915.126ddab5@jack.colino.net> <Pine.LNX.4.61.0504252145220.25129@scrub.home> <20050425220345.6b2ed6d5@jack.colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425220345.6b2ed6d5@jack.colino.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 10:03:45PM +0200, Colin Leroy wrote:
> +	kfree((struct hfsplus_sb_info *)sb->s_fs_info);

absolutely no need to cast here.

