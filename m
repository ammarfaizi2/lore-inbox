Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268980AbUIQUcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268980AbUIQUcJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 16:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268979AbUIQUcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 16:32:08 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:14862 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268980AbUIQU2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 16:28:49 -0400
Date: Fri, 17 Sep 2004 21:28:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmtimer cleanups
Message-ID: <20040917212843.A17201@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <200409171313.12302.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200409171313.12302.jbarnes@engr.sgi.com>; from jbarnes@engr.sgi.com on Fri, Sep 17, 2004 at 01:13:12PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 01:13:12PM -0700, Jesse Barnes wrote:
> A few cleanups that probably should have been done a long time ago:
> 
>   o remove test program from mmtimer.h
>   o move name, desc., etc. #defines from mmtimer.h to mmtimer.c
>   o document what mmtimer.c is a little better
>   o some whitespace cleanups for linewrapping and such
> 
> Signed-off-by: Jesse Barnes <jbarnes@sgi.com>
> 
> Thanks,
> Jesse

> +#define MMTIMER_FULLNAME "/dev/mmtimer"

Shouldn't be needed ;-)

