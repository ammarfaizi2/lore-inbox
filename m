Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756906AbWKVWdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756906AbWKVWdG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 17:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756915AbWKVWdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 17:33:05 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:9634 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1756906AbWKVWdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 17:33:04 -0500
Date: Wed, 22 Nov 2006 14:32:41 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] swsusp: Fix labels
Message-Id: <20061122143241.6b1a34ac.randy.dunlap@oracle.com>
In-Reply-To: <200611190025.06860.rjw@sisk.pl>
References: <200611182335.27453.rjw@sisk.pl>
	<200611182351.01924.rjw@sisk.pl>
	<1163891174.6787.2.camel@nigel.suspend2.net>
	<200611190025.06860.rjw@sisk.pl>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2006 00:25:06 +0100 Rafael J. Wysocki wrote:

> On Sunday, 19 November 2006 00:06, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Sat, 2006-11-18 at 23:51 +0100, Rafael J. Wysocki wrote:
> > > Move all labels in the swsusp code to the second column, so that they won't
> > > fool diff -p.
> > 
> > This sounds like working around brokenness in diff -p. Should/could a
> > patch be submitted to the diff maintainer instead?
> 
> No.  This feature of diff is actually documented.
> 
> There was a discussion on LKML about it some time ago and the patch follows
> the conclusion.

There was discussion, and then both Jesper and I tried to
reproduce the problem with diff and could not do so.
Maybe it has already been fixed. (?)

---
~Randy
