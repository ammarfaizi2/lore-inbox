Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbTI2XKd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 19:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTI2XKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 19:10:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:59368 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263085AbTI2XKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 19:10:32 -0400
Date: Mon, 29 Sep 2003 16:10:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Tim Hockin <thockin@hockin.org>
cc: Pete Zaitcev <zaitcev@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Many groups patch.
In-Reply-To: <20030929155528.A14709@hockin.org>
Message-ID: <Pine.LNX.4.44.0309291609460.12684-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Sep 2003, Tim Hockin wrote:
>
> On Mon, Sep 29, 2003 at 03:43:43PM -0700, Tim Hockin wrote:
> > My version uses a struct group_info which has an array of pages.  The groups
> 
> Woops, patch is here

I'm definitely happier about this one. 

Not that I'm any more thrilled about users using thousands of groups. But 
this looks a bit saner.

		Linus

