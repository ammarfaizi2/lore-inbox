Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267540AbUIWXdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267540AbUIWXdF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267551AbUIWXaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 19:30:04 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:59803
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S267478AbUIWX0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 19:26:47 -0400
Date: Thu, 23 Sep 2004 16:25:35 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
Message-Id: <20040923162535.4ccb32a4.davem@davemloft.net>
In-Reply-To: <E1CAchB-0004VU-00@chiark.greenend.org.uk>
References: <1095962839.4974.965.camel@cube>
	<E1CAchB-0004VU-00@chiark.greenend.org.uk>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004 00:08:13 +0100
Matthew Garrett <mgarrett@chiark.greenend.org.uk> wrote:

> Albert Cahalan <albert@users.sf.net> wrote:
> 
> > Who is doing a 32-bit userland on x86-64, and WTF for?
> > Why do they not also run a 32-bit kernel?
> 
> Debian will be shipping a 32-bit userland with a 64-bit kernel. The
> reasons are long, awkward, and mostly uninteresting. The reason for
> shipping a 64-bit kernel is that it makes it easier for users who
> require large quantities of VM to obtain it.

But just like the sparc64 port, there is a 64-bit userland
compilation environment available, and debian has the means
to ship 64-bit specific packages on top of a mostly 32-bit
userland.  So it is very easy for them to ship a 64-bit
netfilter utility package if they wanted to.
