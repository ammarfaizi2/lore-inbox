Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266173AbSKZFuZ>; Tue, 26 Nov 2002 00:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbSKZFuY>; Tue, 26 Nov 2002 00:50:24 -0500
Received: from ns.suse.de ([213.95.15.193]:11023 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266173AbSKZFuY>;
	Tue, 26 Nov 2002 00:50:24 -0500
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uml-patch-2.5.49-1
References: <200211260517.AAA05038@ccure.karaya.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 26 Nov 2002 06:57:39 +0100
In-Reply-To: Jeff Dike's message of "26 Nov 2002 06:16:24 +0100"
Message-ID: <p73u1i4ub3g.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@karaya.com> writes:
> main points:
> 	the kernel is in a separate process and address space from its processes
> 	UML processes share a single host process

Can you quickly describe why you didn't use one host process per uml
process ? 

That would have avoided the need for a /proc/mm extension too I guess.

-Andi
