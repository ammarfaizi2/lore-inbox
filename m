Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWEOWnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWEOWnY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWEOWnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:43:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58274 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750700AbWEOWnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:43:23 -0400
Subject: Re: [PATCH] jffs2: memory leak in jffs2_scan_medium()
From: David Woodhouse <dwmw2@infradead.org>
To: Florin Malita <fmalita@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4468A450.9000908@gmail.com>
References: <4468A450.9000908@gmail.com>
Content-Type: text/plain
Date: Mon, 15 May 2006 23:43:16 +0100
Message-Id: <1147732996.2571.9.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 11:54 -0400, Florin Malita wrote:
> If jffs2_scan_eraseblock() fails and the exit path is taken, 's' is
> not
> being deallocated.
> 
> Reported by Coverity, CID: 1258.
> 
> Signed-off-by: Florin Malita <fmalita@gmail.com> 

Applied with minor modifications and no trailing whitespace; thanks.

-- 
dwmw2

