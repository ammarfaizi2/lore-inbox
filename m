Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267513AbTBLPwF>; Wed, 12 Feb 2003 10:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267516AbTBLPwF>; Wed, 12 Feb 2003 10:52:05 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:56075
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267513AbTBLPwE>; Wed, 12 Feb 2003 10:52:04 -0500
Subject: Re: sched_init prematurely enables interrupts
From: Robert Love <rml@ufl.edu>
To: Todd Inglett <tinglett@magnaspeed.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E4A4FD8.6070203@magnaspeed.net>
References: <3E4A4FD8.6070203@magnaspeed.net>
Content-Type: text/plain
Organization: 
Message-Id: <1045065727.4234.7.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.0.99 (Preview Release)
Date: 12 Feb 2003 11:02:07 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-12 at 08:44, Todd Inglett wrote:

> The problem is that wake_up_forked_process() does an rq_unlock(rq) which 
> is a spin_unlock_irq.

I believe this is fixed in Linus's bitkeeper.

	Robert Love

