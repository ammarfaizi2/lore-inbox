Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266574AbUIOCKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUIOCKd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 22:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUIOCKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 22:10:33 -0400
Received: from peabody.ximian.com ([130.57.169.10]:15548 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266574AbUIOCKa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 22:10:30 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@ximian.com>
To: Tim Hockin <thockin@hockin.org>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Greg KH <greg@kroah.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040915011146.GA27782@hockin.org>
References: <20040904005433.GA18229@kroah.com>
	 <1094353088.2591.19.camel@localhost> <20040905121814.GA1855@vrfy.org>
	 <20040906020601.GA3199@vrfy.org> <20040910235409.GA32424@kroah.com>
	 <1094875775.10625.5.camel@lucy> <20040911165300.GA17028@kroah.com>
	 <20040913144553.GA10620@vrfy.org> <20040915000753.GA24125@kroah.com>
	 <20040915010901.GA19524@vrfy.org>  <20040915011146.GA27782@hockin.org>
Content-Type: text/plain
Date: Tue, 14 Sep 2004 22:10:29 -0400
Message-Id: <1095214229.20763.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 18:11 -0700, Tim Hockin wrote:

Hey, Tim.

> I don't have any concrete examples right now, but it seems that this is
> being locked down pretty tightly for no real reason...
> 
> Just a passing thought.

I am fearful of the overly strict lock down, too.  I mean, we already
ditched the entire payload.

But so long as you can always add a new action, what complaint do you
have?  In other words, all this does is force the use of the enum, which
ensures that we try to reuse existing actions, prevent typos, and so on.

Cool?

	Robert Love


