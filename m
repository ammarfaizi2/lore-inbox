Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVDEH6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVDEH6p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 03:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVDEH6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:58:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40668 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261596AbVDEHoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:44:25 -0400
Date: Tue, 5 Apr 2005 08:44:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050405074405.GE26208@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050405000524.592fc125.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405000524.592fc125.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 12:05:24AM -0700, Andrew Morton wrote:
> +officially-deprecate-register_ioctl32_conversion.patch
> 
>  deprecate a compat function (mainly affects DRI)

Those DRI callers aren't in mainline but introduced in bk-drm.patch,
looks like the DRI folks need beating with a big stick..

