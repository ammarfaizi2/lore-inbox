Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUHGXdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUHGXdr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 19:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264702AbUHGXdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 19:33:46 -0400
Received: from gate.crashing.org ([63.228.1.57]:7877 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264085AbUHGXdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 19:33:44 -0400
Subject: Re: [PATCH][RESENT] remove hardcoded offsets from ppc asm
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vincent Hanquez <tab@snarc.org>
Cc: Paul Mackerras <paulus@samba.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040807151838.GA6760@snarc.org>
References: <20040807151838.GA6760@snarc.org>
Content-Type: text/plain
Message-Id: <1091921531.14102.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 08 Aug 2004 09:32:12 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-08 at 01:18, Vincent Hanquez wrote:
> 	Hi LKML,
> 
> This patch removes hardcoded offsets from ppc asm.
> It generate offsets for thread_info structure instead of hardcoding them.
> 
> Please apply or comments,
> 
> Signed-off-by: Vincent Hanquez <tab@snarc.org>

I have nothing against the idea, but why the hell did you change the
constant names, turning them partially to lowercase ? They are just
fine beeing uppercase, this is more consistent, and that would
reduce the size of your patch signficantly.

Ben.


