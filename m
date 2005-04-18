Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVDRQn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVDRQn3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 12:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVDRQn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 12:43:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28888 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262087AbVDRQnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 12:43:21 -0400
Date: Mon, 18 Apr 2005 17:43:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <roland@topspin.com>,
       hozer@hozed.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050418164316.GA27697@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Timur Tabi <timur.tabi@ammasso.com>, Andrew Morton <akpm@osdl.org>,
	Roland Dreier <roland@topspin.com>, hozer@hozed.org,
	linux-kernel@vger.kernel.org, openib-general@openib.org
References: <200544159.Ahk9l0puXy39U6u6@topspin.com> <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com> <20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com> <20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com> <20050411171347.7e05859f.akpm@osdl.org> <4263DEC5.5080909@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4263DEC5.5080909@ammasso.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 11:22:29AM -0500, Timur Tabi wrote:
> That's not what we're seeing.  We have hardware that does DMA over the 
> network (much like the Infiniband stuff), and we have a testcase that fails 
> if get_user_pages() is used, but not if mlock() is used.

If you don't share your testcase it's unlikely to be fixed.

