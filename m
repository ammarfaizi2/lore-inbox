Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263856AbVBCUEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263856AbVBCUEL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 15:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbVBCUCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 15:02:32 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:2694 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263834AbVBCTxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 14:53:02 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH] UML - compile fixes for 2.6.11-rc3
Date: Thu, 3 Feb 2005 20:52:16 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200502032056.j13KuLRn004424@ccure.user-mode-linux.org>
In-Reply-To: <200502032056.j13KuLRn004424@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502032052.17102.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 February 2005 21:56, Jeff Dike wrote:
> This fixes UML's sys_call_table to delete some entries for system calls
> which have not yet made it into mainline from -mm.
>
> I also delete UML's __pud_alloc implementation since the memory.c one is
> now enabled.
Ok, thanks.... might you also merge a good fix (either your complete, and 
possibly compilation one, or the one I sent you) about sys/ptrace.h? I've 
seen the complete patch into your tree, however it is not that easy to apply 
- and might maybe (I dunno) give some problems to users with strange 
configurations.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

