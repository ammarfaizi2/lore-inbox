Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbUCJSba (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 13:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbUCJSba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 13:31:30 -0500
Received: from chaos.analogic.com ([204.178.40.224]:41863 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262650AbUCJSb1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 13:31:27 -0500
Date: Wed, 10 Mar 2004 13:33:53 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: "Godbole, Amarendra (GE Consumer & Industrial)" 
	<Amarendra.Godbole@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: (0 == foo), rather than (foo == 0)
In-Reply-To: <20040310100215.1b707504.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.53.0403101324120.18709@chaos>
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com>
 <20040310100215.1b707504.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, Randy.Dunlap wrote:

> On Wed, 10 Mar 2004 11:46:40 +0530 Godbole, Amarendra \(GE Consumer &
> Industrial\) wrote:
>
> Hi,
>
> While writing code, the assignment operator (=) is many-a-times
> confused with the comparison operator (==) resulting in very subtle
> bugs difficult to track. To keep a check on this -- the constant
> can be written on the LHS rather than the RHS which will result
> in a compile time error if wrong operator is used.
>

People who develop kernel code know the difference between
'==' and '=' and are never confused my them. If you make
contributions to kernel code, and write: "if (0==foo)", your
code will be reviewed until it is obsolete and never find
its way into the kernel. Please don't insult kernel developers
with this kind of kid-stuff.

People who develop kernel code also know what a line-warp is.
They put a '\n' "[Enter] key" in their text every so-often,
maybe every 70 to 79 characters...

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


