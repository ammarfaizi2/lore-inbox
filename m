Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263862AbTEOEAI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 00:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbTEOEAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 00:00:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21776 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263862AbTEOD7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:59:40 -0400
Date: Wed, 14 May 2003 21:12:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: James Simmons <jsimmons@infradead.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fbdev patch
In-Reply-To: <Pine.LNX.4.44.0305150110060.19381-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.44.0305142110560.5844-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 May 2003, James Simmons wrote:
>  
> -
> -const struct linux_logo *fb_find_logo(int depth)
> +const struct linux_logo *find_logo(int depth)

Why the heck is this changing back and forth. Please keep the "fb_" 
prefix, and don't change it back and forth, the constant changing just 
confuses everybody way way too much.

		Linus

