Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267860AbUJMImV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267860AbUJMImV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 04:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267840AbUJMImU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 04:42:20 -0400
Received: from palrel13.hp.com ([156.153.255.238]:28382 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S267826AbUJMImQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 04:42:16 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16748.60002.875945.950324@napali.hpl.hp.com>
Date: Wed, 13 Oct 2004 01:42:10 -0700
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: davidm@hpl.hp.com, akepner@sgi.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, akpm@osdl.org, jbarnes@sgi.com
Subject: Re: bug in 2.6.9-rc4-mm1 ia64/mm/init.c
In-Reply-To: <416CEADA.2060207@jp.fujitsu.com>
References: <Pine.LNX.4.33.0410121705510.31839-100000@localhost.localdomain>
	<16748.57721.66330.638048@napali.hpl.hp.com>
	<416CEADA.2060207@jp.fujitsu.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 13 Oct 2004 17:44:10 +0900, Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com> said:

  Hiroyuki> My purpose was to reduce # of page fault when
  Hiroyuki> ia64_pfn_valid() is called.  It is called heavily in
  Hiroyuki> bad_range() (in mm/page_alloc.c) now.

At the expense of ignoring perfectly good memory?  Or did I miss something?

	--david
