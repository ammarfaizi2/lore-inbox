Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268316AbUJOSnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268316AbUJOSnl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 14:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUJOSkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 14:40:51 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:45488 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S268084AbUJOSkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 14:40:11 -0400
Date: Fri, 15 Oct 2004 20:40:09 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Albert Cahalan <albert@users.sf.net>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: per-process shared information
Message-ID: <20041015184009.GG17849@dualathlon.random>
References: <Pine.LNX.4.44.0410151207140.5682-100000@localhost.localdomain> <1097846353.2674.13298.camel@cube> <20041015162000.GB17849@dualathlon.random> <1097857912.2669.13548.camel@cube> <20041015171355.GD17849@dualathlon.random> <1097862714.2666.13650.camel@cube> <20041015181446.GF17849@dualathlon.random> <20041015183025.GN5607@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015183025.GN5607@holomorphy.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 11:30:25AM -0700, William Lee Irwin III wrote:
> I just checked in with some Oracle people and the primary concern
> is splitting up RSS into shared and private. Given either shared
> or private the other is calculable.

can you define private a bit more? Is private the page_count == 1 like
2.4? Or is "private" == anonymous? that's the only question.

In Hugh's patch private == "anonymous". With 2.4 private == "page_count
== 1" (which is a subset of anonymous).
