Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVCUVPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVCUVPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVCUVMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 16:12:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18153 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261914AbVCUVER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 16:04:17 -0500
Date: Mon, 21 Mar 2005 21:04:13 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 529] M68k: Update signal delivery handling
Message-ID: <20050321210413.GA3366@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <200503212025.j2LKPntC011301@anakin.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503212025.j2LKPntC011301@anakin.of.borg>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 09:25:49PM +0100, Geert Uytterhoeven wrote:
> M68k: Update signal delivery handling, which was broken by the removal of
> notify_parent() in 2.6.9-rc2

After that patch the #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER in
kernel/signal.c can go away now.

