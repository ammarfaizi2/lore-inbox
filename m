Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268313AbUIWTea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268313AbUIWTea (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 15:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268306AbUIWTea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 15:34:30 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:51864
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268334AbUIWTeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 15:34:02 -0400
Date: Thu, 23 Sep 2004 12:32:50 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Andi Kleen <ak@muc.de>
Cc: prasanna@in.ibm.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org, suparna@in.ibm.com, trini@kernel.crashing.org,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Patch] kprobes exception notifier fix 2.6.9-rc2
Message-Id: <20040923123250.5e62f547.davem@davemloft.net>
In-Reply-To: <20040923080627.GA89752@muc.de>
References: <20040923053029.GB1291@in.ibm.com>
	<20040923080627.GA89752@muc.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Sep 2004 10:06:28 +0200
Andi Kleen <ak@muc.de> wrote:

> On Thu, Sep 23, 2004 at 11:00:29AM +0530, Prasanna S Panchamukhi wrote:
> > In order to make other debuggers use exception notifiers, kprobes 
> > notifier return values are required to be modified. This patch modifies the
> > return values of kprobes notifier return values in a clean way.
> 
> It's incompatible to x86-64. If you change anything in exception
> notifiers change both.

And please change sparc64 as well, as it has the same exception
notification implemented there as well.
