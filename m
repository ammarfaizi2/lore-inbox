Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbTFYFSq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 01:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbTFYFSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 01:18:46 -0400
Received: from dp.samba.org ([66.70.73.150]:50668 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261785AbTFYFSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 01:18:46 -0400
Date: Wed, 25 Jun 2003 15:29:40 +1000
From: Anton Blanchard <anton@samba.org>
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Speeding up Linux kernel compiles using -pipe?
Message-ID: <20030625052940.GA18786@krispykreme>
References: <000001c33ad1$5c415ff0$030aa8c0@panic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c33ad1$5c415ff0$030aa8c0@panic>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why aren't we using -pipe? It can significantly speed up compiles by not
> writing temp files (intermediate files).

I thought we were. Do you have results to show it speeds up kernel
compiles? I found the opposite when using ext2:

http://www.ussg.iu.edu/hypermail/linux/kernel/0212.1/0040.html

Anton
