Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933052AbWFZVVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933052AbWFZVVG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 17:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933053AbWFZVVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 17:21:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:22474 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S933052AbWFZVVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 17:21:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=bo3DCUHsr5gyEdCWVDZVyxZZXinVFMjVFWyHipq2+sBZQ0JWI1wcGd7YOA4ANtj1/1y2q0Iq6bMa9OaPA1L9mxN45kMHqe7lrCvsFI/AJnzlofVcnepOXT03lWDdbEdTGOlf5wmDU/3qDeHCtarSo2pJNWB7zdyT2miIjxsVfUY=
Date: Tue, 27 Jun 2006 01:21:01 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] fs/mpage.c: unexport mpage_writepage
Message-ID: <20060626212101.GA7557@martell.zuzino.mipt.ru>
References: <20060626205633.GF23314@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626205633.GF23314@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 10:56:33PM +0200, Adrian Bunk wrote:
> This patch removes the unused EXPORT_SYMBOL(mpage_writepage).

> -EXPORT_SYMBOL(mpage_writepage);

mpage_readpage		mpage_writepage
mpage_readpages		mpage_writepages

Shoot me but this symmetric picture should stay. It's a library, sigh.

