Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUCZVdl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbUCZVdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:33:41 -0500
Received: from palrel11.hp.com ([156.153.255.246]:23456 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261234AbUCZVbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:31:48 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16484.41279.183108.394920@napali.hpl.hp.com>
Date: Fri, 26 Mar 2004 13:31:43 -0800
To: Dave Jones <davej@redhat.com>
Cc: davidm@hpl.hp.com, Andrew Morton <akpm@osdl.org>, davidm@napali.hpl.hp.com,
       mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: Fw: potential /dev/urandom scalability improvement
In-Reply-To: <20040326182326.GM22561@redhat.com>
References: <20040325141923.7080c6f0.akpm@osdl.org>
	<20040325224726.GB8366@waste.org>
	<16483.35656.864787.827149@napali.hpl.hp.com>
	<20040325180014.29e40b65.akpm@osdl.org>
	<20040326110619.GA25210@redhat.com>
	<16484.29095.842735.102236@napali.hpl.hp.com>
	<20040326182326.GM22561@redhat.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 26 Mar 2004 18:23:26 +0000, Dave Jones <davej@redhat.com> said:

  Dave> The proposed only user of this may take care of this
  Dave> requirement, but I'm more concerned someone not aware of this
  Dave> requirement using this helper routine. At the least it
  Dave> deserves a comment IMO.

A comment sounds like a fine idea.  But while at it, the equivalent
comment for prefetch() and prefetchw() seems just as appropriate and
perhaps even more important.

	--david
