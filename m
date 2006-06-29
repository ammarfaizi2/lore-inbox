Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933055AbWF2WQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933055AbWF2WQt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933049AbWF2WPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:15:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14818 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S933048AbWF2WPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 18:15:04 -0400
Subject: Re: [2.6 patch] fs/jffs2/: make 2 functions static
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, jffs-dev@axis.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060628165455.GT13915@stusta.de>
References: <20060628165455.GT13915@stusta.de>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 23:14:45 +0100
Message-Id: <1151619285.18930.27.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-28 at 18:54 +0200, Adrian Bunk wrote:
> This patch makes two needlessly global functions static.

Applied; thanks.

To be honest though, I'd _much_ rather get GCC bugs 27898 and 27899
fixed and start building stuff like file systems with -fwhole-program
--combine. It gives about a 4% reduction in code size.

-- 
dwmw2

