Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVCORfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVCORfh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVCORdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:33:22 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:60057 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261656AbVCORc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:32:58 -0500
Date: Tue, 15 Mar 2005 10:32:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc32: Fix a warning in planb video driver
Message-ID: <20050315173253.GA30353@smtp.west.cox.net>
References: <20050315170112.GQ8345@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315170112.GQ8345@smtp.west.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 10:01:12AM -0700, Tom Rini wrote:
> [ aside: This has been sitting in the linuxppc-2.5 bk tree for I don't
>   know how long.  And the driver is still horribly broken. ]
> 
> The following patch moves overlay_is_active to before its first use.  It
> was originally written when gcc wouldn't complain, but now does, about
> not having the definition before usage.

Oops,
Signed-off-by: Tom Rini <trini@kernel.crashing.org>

-- 
Tom Rini
http://gate.crashing.org/~trini/
