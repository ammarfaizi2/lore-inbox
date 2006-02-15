Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423058AbWBOJHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423058AbWBOJHV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 04:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423057AbWBOJHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 04:07:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43734 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423058AbWBOJHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 04:07:08 -0500
Date: Wed, 15 Feb 2006 01:05:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] make sysctl_overcommit_memory enumeration sensible
Message-Id: <20060215010559.55b55414.akpm@osdl.org>
In-Reply-To: <20060215085456.GA2481@localhost.localdomain>
References: <20060215085456.GA2481@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt <qiyong@fc-cn.com> wrote:
>
> I see system admins often confused when they sysctl vm.overcommit_memory.
> This patch makes overcommit_memory enumeration sensible.
> 
> 0 - no overcommit
> 1 - always overcommit
> 2 - heuristic overcommit (default)
> 
> I don't feel this would break any userspace scripts.

eh?   If any such scripts exist, they'll break.

Confused.
