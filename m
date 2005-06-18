Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVFRBwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVFRBwN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 21:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVFRBwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 21:52:13 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:5763 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261730AbVFRBwK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 21:52:10 -0400
X-ORBL: [63.202.173.158]
Date: Fri, 17 Jun 2005 18:51:52 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Robert Love <rml@novell.com>, Zach Brown <zab@zabbo.net>,
       linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] inotify.
Message-ID: <191951.1275e84aabedf37c16209d36573e55ca.ANY@taniwha.stupidest.org>
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net> <1118946334.3949.63.camel@betsy> <200506171907.39940.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506171907.39940.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 07:07:38PM +0200, Arnd Bergmann wrote:

> in inotify is _very_ similar to how epoll is represented to user
> space. Is there a good reason that epoll is a set of syscalls while
> inotify is a character device, or is one of them simply wrong?

Tangentially inotify does some of what the DMAPI interface(s) want to
do (albeit somewhat simpler).  It would seem since DMAPI in it's
current incarnation won't "go away and die[1]" it might be worth
considering how much overlap there is.


[1] More than one fs has this out-of-tree and people are using it in
    various forms.
