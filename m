Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWAFPua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWAFPua (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWAFPua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:50:30 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:39599 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932447AbWAFPu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:50:29 -0500
Date: Fri, 6 Jan 2006 11:39:48 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] UML - Prevent MODE_SKAS=n and MODE_TT=n
Message-ID: <20060106163948.GA4340@ccure.user-mode-linux.org>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org> <20060104152433.7304ec75.akpm@osdl.org> <20060105022129.GA13183@ccure.user-mode-linux.org> <20060106124438.GB12131@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106124438.GB12131@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 01:44:38PM +0100, Adrian Bunk wrote:
> If MODE_TT=n, MODE_SKAS must be y.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Great.  Now, how do you simultaneously implement 
	If MODE_SKAS=n, MODE_TT must be y.

				Jeff
