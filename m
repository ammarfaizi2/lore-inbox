Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270514AbUJUAMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270514AbUJUAMu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 20:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269187AbUJUALv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:11:51 -0400
Received: from cantor.suse.de ([195.135.220.2]:64717 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S270517AbUJUAKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 20:10:54 -0400
Date: Thu, 21 Oct 2004 02:10:42 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andi Kleen <ak@suse.de>, dhowells@redhat.com, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       sparclinux@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-m68k@vger.kernel.org, linux-sh@m17n.org,
       linux-arm-kernel@lists.arm.linux.org.uk, parisc-linux@parisc-linux.org,
       linux-ia64@vger.kernel.org, linux-390@vm.marist.edu,
       linux-mips@linux-mips.org
Subject: Re: [discuss] Re: [PATCH] Add key management syscalls to non-i386 archs
Message-ID: <20041021001041.GI995@wotan.suse.de>
References: <3506.1098283455@redhat.com> <20041020150149.7be06d6d.davem@davemloft.net> <20041020225625.GD995@wotan.suse.de> <20041020160450.0914270b.davem@davemloft.net> <20041020232509.GF995@wotan.suse.de> <20041020164144.3457eafe.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020164144.3457eafe.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 04:41:44PM -0700, David S. Miller wrote:
> On Thu, 21 Oct 2004 01:25:09 +0200
> Andi Kleen <ak@suse.de> wrote:
> 
> > IMHO breaking the build unnecessarily is extremly bad because
> > it will prevent all testing. And would you really want to hold
> > up the whole linux testing machinery just for some obscure 
> > system call? IMHO not a good tradeoff.
> 
> Then change the unistd.h cookie from "#error" to a "#warning".  It
> accomplishes both of our goals.

#warnings would be fine for me.

-Andi
