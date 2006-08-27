Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWH0RRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWH0RRl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 13:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWH0RRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 13:17:41 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:42453 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932189AbWH0RRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 13:17:41 -0400
Date: Sun, 27 Aug 2006 19:17:28 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Ian Lindsay <iml@formicary.org>
Cc: fsdevel@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Subject: Re: LogFS
Message-ID: <20060827171728.GB3502@wohnheim.fh-wedel.de>
References: <20060824134430.GB17132@wohnheim.fh-wedel.de> <20060827053245.GA15747@gen.formicary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060827053245.GA15747@gen.formicary.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 August 2006 01:32:45 -0400, Ian Lindsay wrote:
> 
>  +/* FIXME: This should really be somewhere in the 64bit area. */
>  +#define LOGFS_LINK_MAX (2^30)
> 
> Interesting choice of constant.

Yes.  I didn't spend a long time thinking about whether it should be
2^31 or 2^31-1 or 2^31-2.  It will be a while before it becomes an
issue in real life anyway. :)

Jörn

-- 
It's not whether you win or lose, it's how you place the blame.
-- unknown
