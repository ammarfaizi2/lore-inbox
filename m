Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268982AbUJQFNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268982AbUJQFNS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 01:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269056AbUJQFNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 01:13:18 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:46223 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268982AbUJQFNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 01:13:16 -0400
Subject: Re: Building on case-insensitive systems
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: sam@ravnborg.org, dank@kegel.com
Content-Type: text/plain
Organization: 
Message-Id: <1097989574.2674.14246.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Oct 2004 01:06:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There are today ~1400 files named *.S in the tree, but none named *.s.
> So my idea was to do it like:
> *.S => *.asm => *.o

The logic is sound, but... yuck!

> Btw. this is not about "case-challenged" filesystems in general.
> This is about making the kernel usefull out-of-the-box for the
> increasing embedded market. Less work-around patces needed the
> better. And these people are oftenb ound to Windoze boxes - for
> different reasons. And the individual developer may not be able
> to change this.

The difficulty in building on a case-insensitive filesystem may
be the only hope these developers have for escaping Windows.
You turn "we must have Linux build systems to build our product"
into the less effective "we want Linux".       

For the sake of these suffering developers, it would be better
to make sure that building Linux on Windows is a lost cause.
We could name a file "con" or "a:foo" for example.


