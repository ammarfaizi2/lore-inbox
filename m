Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbUFFHcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUFFHcp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 03:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUFFHcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 03:32:45 -0400
Received: from [213.146.154.40] ([213.146.154.40]:41919 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263019AbUFFHco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 03:32:44 -0400
Date: Sun, 6 Jun 2004 08:32:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike McCormack <mike@codeweavers.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040606073241.GA6214@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike McCormack <mike@codeweavers.com>, mingo@elte.hu,
	linux-kernel@vger.kernel.org
References: <40C2B51C.9030203@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C2B51C.9030203@codeweavers.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2004 at 03:09:32PM +0900, Mike McCormack wrote:
> Fedore Code 1's exec-shield patch broke Wine badly, as there was no way 
> for an application to turn it off from user space, and Wine depended 
> upon certain areas of virtual memory being free.

if you have a need for a special virtual memory layout please use your
own binary loader as I already suggested earlier in the thread, i.e.
binfmt_pecoff.

