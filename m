Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbUJ0Ar7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbUJ0Ar7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbUJ0Ar7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:47:59 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:38605 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261579AbUJ0Aro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:47:44 -0400
Date: Wed, 27 Oct 2004 02:48:36 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, riel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
Message-ID: <20041027004836.GN14325@dualathlon.random>
References: <20041025170128.GF14325@dualathlon.random> <Pine.LNX.4.44.0410252147330.30224-100000@chimarrao.boston.redhat.com> <20041026015825.GU14325@dualathlon.random> <417DC8F2.7000902@yahoo.com.au> <20041026040429.GW14325@dualathlon.random> <417DCFDD.50606@yahoo.com.au> <20041027002536.GM14325@dualathlon.random> <20041026174237.44ab2b23.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026174237.44ab2b23.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 05:42:37PM -0700, Andrew Morton wrote:
> Andrea Arcangeli <andrea@novell.com> wrote:
> >
> > I don't see any other equivalent teminology besides my "classzone" word
> > existing,
> 
> I'll confess that I've never understood what "classzone" _means_.  Is it "a
> zone from amongst several classes" or what?
> 
> If it was "zone_class" then it might mean "a particular classification of
> zones".  Maybe that's what you meant?
> 
> I think a lot of other mm hackers share my confusion, which is why
> "classzone" has been trickling away.  But yeah, we haven't been replacing it
> with anything very useful.

it's very easy to explain it now that you spontanously used that concept
in 2.6: classzone is the piece of ram represented by what you previously
called alloc_type in 2.6.9 mainline alloc_pages function. You wrote that
code so you know what it means. If you prefer to still call that
alloc_type that's fine with me.
