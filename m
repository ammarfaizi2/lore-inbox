Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273053AbRJBEOt>; Tue, 2 Oct 2001 00:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275806AbRJBEOj>; Tue, 2 Oct 2001 00:14:39 -0400
Received: from h24-78-175-24.vn.shawcable.net ([24.78.175.24]:34193 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S275805AbRJBEOd>;
	Tue, 2 Oct 2001 00:14:33 -0400
Date: Mon, 1 Oct 2001 21:14:59 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stateful Magic Sysrq Key
Message-ID: <20011001211459.A6957@netnation.com>
In-Reply-To: <20011001234437.A10994@mueller.datastacks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011001234437.A10994@mueller.datastacks.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2001 at 11:44:37PM -0400, Crutcher Dunnavant wrote:

> This patch was developed to handle crappy KVM-alikes, which did one key
> at a time, and had no SysRq key. However, it gives a good solution to a
> common problem. Many keyboards are made cheaply, and do not support
> having large numbers of keys pressed simultaneously, making the current
> SysRq code almost useless on them.

This iss sort of funny...A number of people at the office thought SysRq
was already stateful because there are a number of keyboards that do not
send a release event when alt+sysrq+another key are pressed
simultaneously....It actually makes it look like alt-sysrq is pressed
until alt-sysrq is actually pressed again without any keys following it. 
I suppose this patch makes this cheap keyboard flaw transparent. :)

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
