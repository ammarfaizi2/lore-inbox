Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268991AbUIQP53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268991AbUIQP53 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 11:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268968AbUIQPyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:54:33 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:34506 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269000AbUIQPyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 11:54:05 -0400
Subject: Re: [RFC][PATCH] inotify 0.9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@novell.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Jan Kara <jack@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1095436123.23385.182.camel@betsy.boston.ximian.com>
References: <Pine.LNX.3.96.1040916182127.20906B-100000@gatekeeper.tmr.com>
	 <1095376979.23385.176.camel@betsy.boston.ximian.com>
	 <1095377752.23913.3.camel@localhost.localdomain>
	 <1095388176.20763.29.camel@localhost>
	 <1095431960.26147.13.camel@localhost.localdomain>
	 <1095436123.23385.182.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095432696.26146.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 17 Sep 2004 15:51:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-17 at 16:48, Robert Love wrote:
> I've looked into more "indexing" specific solutions and you see both
> races and security issues when you move away from the subscribe-to-
> watch-each-inode model.

For the file change case I'm unconvinced, although it looks like it
could be done with the security module hooks and without kernel mods
beyond that.


