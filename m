Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWAGEcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWAGEcu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 23:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbWAGEcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 23:32:50 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:3766 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932313AbWAGEct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 23:32:49 -0500
Date: Sat, 7 Jan 2006 00:22:46 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] UML - Prevent MODE_SKAS=n and MODE_TT=n
Message-ID: <20060107052246.GA15654@ccure.user-mode-linux.org>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org> <20060104152433.7304ec75.akpm@osdl.org> <20060105022129.GA13183@ccure.user-mode-linux.org> <20060106124438.GB12131@stusta.de> <20060106163948.GA4340@ccure.user-mode-linux.org> <20060106161831.GH12131@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106161831.GH12131@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 05:18:31PM +0100, Adrian Bunk wrote:
> That is already implemented in my patch:
> 
> MODE_TT=n forces MODE_SKAS=y.
> MODE_TT=y allows any setting of MODE_SKAS.
> 
> MODE_SKAS=n is therefore impossible if MODE_TT=n.

Right you are.

		Jeff
