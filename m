Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263454AbTJBRbf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 13:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263482AbTJBRbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 13:31:35 -0400
Received: from zamok.crans.org ([138.231.136.6]:3513 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S263454AbTJBRbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 13:31:33 -0400
Date: Thu, 2 Oct 2003 19:31:32 +0200
To: Petri Koistinen <petri.koistinen@iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ksoftirqd & kswapd returning nothing while non-void
Message-ID: <20031002173132.GA11177@darwin.crans.org>
References: <Pine.LNX.4.58.0310021953260.5991@dsl-hkigw4g29.dial.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0310021953260.5991@dsl-hkigw4g29.dial.inet.fi>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.4i
From: Vincent Hanquez <tab@tuxfamily.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 02, 2003 at 07:59:20PM +0300, Petri Koistinen wrote:
> Hi!
> 
> I just compiled latest 2.6.0-test kernel and noticed these two warnings:
> [snip]
> 
> Is here something that should be worried about?

kswapd and ksoftirqd are daemons which never returns (loop forever).
to squeeze the warnings it may be good to set a fake return statement;

-- 
Tab
