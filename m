Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292593AbSCOOZc>; Fri, 15 Mar 2002 09:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292555AbSCOOZX>; Fri, 15 Mar 2002 09:25:23 -0500
Received: from zero.tech9.net ([209.61.188.187]:49425 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292574AbSCOOZL>;
	Fri, 15 Mar 2002 09:25:11 -0500
Subject: Re: 2.4.18 Preempt Freezeups
From: Robert Love <rml@tech9.net>
To: Ian Duggan <ian@ianduggan.net>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C91B2A1.48C74B82@ianduggan.net>
In-Reply-To: <3C9153A7.292C320@ianduggan.net>
	<1016157250.4599.62.camel@phantasy>  <3C91B2A1.48C74B82@ianduggan.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 15 Mar 2002 09:25:09 -0500
Message-Id: <1016202310.908.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-03-15 at 03:36, Ian Duggan wrote:

> I'm not asking for help fixing it, because of the binary module issue.
> I'm just looking for ways to narrow down where the problem might be,
> given that the machine completely locks up.

Chances are the binary win4lin module just needs to be recompiled
against a preemptive kernel.

Of course, it could need some specific preempt-safe work but more than
likely it just needs to be recompiled.  Binary modules most be
specifically preempt-kernel aware, like they need be SMP-kernel aware.

	Robert Love

