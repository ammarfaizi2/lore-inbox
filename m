Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269060AbUIQWEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269060AbUIQWEN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 18:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269065AbUIQWEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 18:04:13 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:28822 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S269060AbUIQWDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 18:03:50 -0400
Date: Fri, 17 Sep 2004 15:03:40 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, kkeil@suse.de
Subject: Re: [patch] tune vmalloc size
Message-ID: <20040917220340.GA2890@taniwha.stupidest.org>
References: <2EHyq-5or-39@gated-at.bofh.it> <m34qlzbqy6.fsf@averell.firstfloor.org> <1095257576.2698.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095257576.2698.4.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 04:12:56PM +0200, Arjan van de Ven wrote:

> that is the case already

why do we still use 128MB as a default then?  this is way over-kill
from what i can tell looking on what my machines use.  i'd rather have
this be a bit smaller and enable the slab/whatever to grow a little
more
