Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755359AbWKRX2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359AbWKRX2p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 18:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755371AbWKRX2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 18:28:45 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:36272 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1755359AbWKRX2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 18:28:44 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH 4/4] swsusp: Fix labels
Date: Sun, 19 Nov 2006 00:25:06 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       LKML <linux-kernel@vger.kernel.org>
References: <200611182335.27453.rjw@sisk.pl> <200611182351.01924.rjw@sisk.pl> <1163891174.6787.2.camel@nigel.suspend2.net>
In-Reply-To: <1163891174.6787.2.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611190025.06860.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 19 November 2006 00:06, Nigel Cunningham wrote:
> Hi.
> 
> On Sat, 2006-11-18 at 23:51 +0100, Rafael J. Wysocki wrote:
> > Move all labels in the swsusp code to the second column, so that they won't
> > fool diff -p.
> 
> This sounds like working around brokenness in diff -p. Should/could a
> patch be submitted to the diff maintainer instead?

No.  This feature of diff is actually documented.

There was a discussion on LKML about it some time ago and the patch follows
the conclusion.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
