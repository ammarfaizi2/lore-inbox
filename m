Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVCFWzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVCFWzY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 17:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVCFWvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:51:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19621 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261600AbVCFWr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:47:27 -0500
Date: Sun, 6 Mar 2005 22:47:26 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mm/{mmap,nommu}.c: several unexports
Message-ID: <20050306224726.GD5827@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20050306144319.GG5070@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050306144319.GG5070@stusta.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 03:43:19PM +0100, Adrian Bunk wrote:
> I didn't find any possible modular usage in the kernel.
> 
>

These were there because we had core MM dunctionality duplicated in
every security module.  They definitly shouldn't be exported.

