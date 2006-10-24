Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161203AbWJXTNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161203AbWJXTNl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 15:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161205AbWJXTNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 15:13:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48647 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1161203AbWJXTNb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 15:13:31 -0400
Date: Tue, 24 Oct 2006 08:40:03 +0000
From: Pavel Machek <pavel@ucw.cz>
To: David Miller <davem@davemloft.net>
Cc: torvalds@osdl.org, ctpm@ist.utl.pt, linux-kernel@vger.kernel.org
Subject: Re: Unintended commit?
Message-ID: <20061024084002.GB4299@ucw.cz>
References: <200610231809.09238.ctpm@ist.utl.pt> <Pine.LNX.4.64.0610231013340.3962@g5.osdl.org> <20061023.141040.59654407.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023.141040.59654407.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Perhaps it would be cool if you could tell GIT "Look, I know I have
> a change to foo.c, but it's a local hack and please act like it's
> not there unless I try to do an operation where ignoring that change
> is impossible, such as a merge."

When  I was solving that problem, I ended up with two repositories:

clean-linus <-> linux-pavels-hacks <-> linux.

That behaves mostly as you want it...

							Pavel
-- 
Thanks for all the (sleeping) penguins.
