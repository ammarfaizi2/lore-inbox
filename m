Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbVH3QSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVH3QSR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVH3QSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:18:17 -0400
Received: from cantor2.suse.de ([195.135.220.15]:2534 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932199AbVH3QSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:18:16 -0400
Date: Tue, 30 Aug 2005 18:18:14 +0200
From: Olaf Hering <olh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20050830161814.GA31940@suse.de>
References: <20050830145444.GC3708@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050830145444.GC3708@stusta.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Aug 30, Adrian Bunk wrote:

> Currently, using an undeclared function gives a compile warning, but it 
> can lead to a link or even a runtime error.
> 
> With -Werror-implicit-function-declaration, we are getting an immediate 
> compile error instead.

You have to fix CONFIG_SWAP=n as well.

http://lkml.org/lkml/2005/8/6/72

