Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270537AbUJTXrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270537AbUJTXrv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270521AbUJTXro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:47:44 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:53152
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S270506AbUJTXrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:47:23 -0400
Date: Wed, 20 Oct 2004 16:41:44 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Andi Kleen <ak@suse.de>
Cc: ak@suse.de, dhowells@redhat.com, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       sparclinux@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-m68k@vger.kernel.org, linux-sh@m17n.org,
       linux-arm-kernel@lists.arm.linux.org.uk, parisc-linux@parisc-linux.org,
       linux-ia64@vger.kernel.org, linux-390@vm.marist.edu,
       linux-mips@linux-mips.org
Subject: Re: [discuss] Re: [PATCH] Add key management syscalls to non-i386
 archs
Message-Id: <20041020164144.3457eafe.davem@davemloft.net>
In-Reply-To: <20041020232509.GF995@wotan.suse.de>
References: <3506.1098283455@redhat.com>
	<20041020150149.7be06d6d.davem@davemloft.net>
	<20041020225625.GD995@wotan.suse.de>
	<20041020160450.0914270b.davem@davemloft.net>
	<20041020232509.GF995@wotan.suse.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004 01:25:09 +0200
Andi Kleen <ak@suse.de> wrote:

> IMHO breaking the build unnecessarily is extremly bad because
> it will prevent all testing. And would you really want to hold
> up the whole linux testing machinery just for some obscure 
> system call? IMHO not a good tradeoff.

Then change the unistd.h cookie from "#error" to a "#warning".  It
accomplishes both of our goals.
