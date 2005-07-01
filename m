Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262783AbVGAV6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbVGAV6S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 17:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVGAV6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 17:58:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33687 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262783AbVGAV5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 17:57:16 -0400
Date: Fri, 1 Jul 2005 14:58:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       "blaisorblade@yahoo.it" <blaisorblade_spam@yahoo.it>
Subject: Re: [PATCH 1/2] UML - skas0 - separate kernel address space on
 stock hosts
Message-Id: <20050701145802.5cebabd2.akpm@osdl.org>
In-Reply-To: <200507012131.j61LVCLi027276@ccure.user-mode-linux.org>
References: <200507012131.j61LVCLi027276@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> wrote:
>
> This patch implements something very close to skas mode for hosts
> which don't support skas - I'm calling this skas0.

I note that this patch assumes that
uml-kill-some-useless-vmalloc-tlb-flushing.patch is applied.

AFAIK that patch is still in limbo due to objections from Paolo.  Can we
sort that out please?
