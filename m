Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbVIRUHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbVIRUHJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 16:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVIRUHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 16:07:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55730 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751322AbVIRUHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 16:07:07 -0400
Date: Sun, 18 Sep 2005 13:06:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] introduce setup_timer() helper
Message-Id: <20050918130613.5bbe9344.akpm@osdl.org>
In-Reply-To: <432D9432.5C5B64D6@tv-sign.ru>
References: <432D70C8.EF7B0438@tv-sign.ru>
	<1127056369.30256.4.camel@localhost.localdomain>
	<432D8CF8.C14C48A0@tv-sign.ru>
	<20050918154301.GA9088@devserv.devel.redhat.com>
	<432D9432.5C5B64D6@tv-sign.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> I think this can save a couple of cpu cycles. The init_timer()
>  is not inline, gcc can't reorder exprx() and init_timer() calls.
> 
>  Ok, I do not want to persist very much, I can resend this patch.
> 
>  Andrew, should I?

Try both, see which one generates the shorter code?
