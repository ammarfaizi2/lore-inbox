Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVCKQQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVCKQQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 11:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVCKQQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 11:16:42 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:1034 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261169AbVCKQQe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 11:16:34 -0500
Message-Id: <200503111847.j2BIl1Jp003348@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Linus Torvalds <torvalds@osdl.org>
cc: Adrian Bunk <bunk@stusta.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       jdike@ccure.user-mode-linux.org
Subject: Re: [PATCH 4/9] UML - Export gcov symbol based on gcc version 
In-Reply-To: Your message of "Thu, 10 Mar 2005 15:21:42 PST."
             <Pine.LNX.4.58.0503101516190.2530@ppc970.osdl.org> 
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org> <20050310225340.GD3205@stusta.de>  <Pine.LNX.4.58.0503101516190.2530@ppc970.osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 11 Mar 2005 13:47:01 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@osdl.org said:
> Can't we just fix it by havign an alias for both names? It seems
> stupid to  jump through hoops and worry about compiler versions, when
> afaik we could  just do something like

> 	extern xxxx(...) __attribute__((alias("yyyy")));

> instead. Exact details left to the reader who knows more about all the
>  magic gcc/linker things.. 

OK, this exceeds my current linker-fu, but I'll take a look and get a better
fix for this.

				Jeff

