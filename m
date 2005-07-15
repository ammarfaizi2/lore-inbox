Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVGOSyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVGOSyC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 14:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVGOSyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 14:54:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38029 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263357AbVGOSxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 14:53:20 -0400
Date: Fri, 15 Jul 2005 11:52:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Blunck <j.blunck@tu-harburg.de>
cc: Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ramfs: pretend dirent sizes
In-Reply-To: <42D72705.8010306@tu-harburg.de>
Message-ID: <Pine.LNX.4.58.0507151151360.19183@g5.osdl.org>
References: <42D72705.8010306@tu-harburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Jul 2005, Jan Blunck wrote:
>
> This patch adds bogo dirent sizes for ramfs like already available for 
> tmpfs.

I really think you should update the "simple_xxx()" functions instead, and 
thus make this happen for _any_ filesystem that uses the simple fs helper 
functions.

		Linus
