Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263936AbTEWIdc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 04:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbTEWIdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 04:33:32 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:40216 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263936AbTEWIdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 04:33:31 -0400
Date: Fri, 23 May 2003 01:49:34 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC] probably bug in current ext3/jbd
Message-Id: <20030523014934.37a1c10d.akpm@digeo.com>
In-Reply-To: <8765o1x6mb.fsf@gw.home.net>
References: <87d6igmarf.fsf@gw.home.net>
	<1053376482.11943.15.camel@sisko.scot.redhat.com>
	<87he7qe979.fsf@gw.home.net>
	<1053377493.11943.32.camel@sisko.scot.redhat.com>
	<87addhd2mc.fsf@gw.home.net>
	<20030521093848.59ada625.akpm@digeo.com>
	<87smr8c9le.fsf@gw.home.net>
	<20030521095921.4f457002.akpm@digeo.com>
	<m3brxwe2lr.fsf@lexa.home.net>
	<20030521103737.52eddeb3.akpm@digeo.com>
	<87n0hgc6s6.fsf@gw.home.net>
	<20030521105011.2d316baf.akpm@digeo.com>
	<87k7ckc5z2.fsf@gw.home.net>
	<20030521143140.3aaa86ba.akpm@digeo.com>
	<8765o1x6mb.fsf@gw.home.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 May 2003 08:46:37.0393 (UTC) FILETIME=[D2574C10:01C32107]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
> here is small patch that intented to fix race with b_committed_data.

Thanks, it looks good.

The balloc.c code is getting awfully convoluted and hard to follow,
but no obvious restructuring strategies are leaping out at me.
