Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTI3POf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 11:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbTI3POf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 11:14:35 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52134 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261598AbTI3PO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 11:14:27 -0400
Date: Tue, 30 Sep 2003 16:57:23 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Boszormenyi Zoltan <zboszor@externet.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] exec-shield-2.6.0-test6-G3
In-Reply-To: <3F77F752.7020404@externet.hu>
Message-ID: <Pine.LNX.4.56.0309301655330.9692@localhost.localdomain>
References: <3F77F752.7020404@externet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Sep 2003, Boszormenyi Zoltan wrote:

> this is a version against -test6-mm1.
> Three differences from -test6-G3:
> - Makefile EXTRAVERSION
> - include/asm-i386/mmu.h trivial reject fix
> - fs/proc/array.c, {task|current}->[e]uid replaced
>    with tsk_[e]uid({task|current}) to compile.

thanks, looks good. I've uploaded it to:

	redhat.com/~mingo/exec-shield/exec-shield-2.6.0-test6-mm1-G3

    Ingo
