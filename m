Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264628AbUD1D0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264628AbUD1D0m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 23:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264629AbUD1D0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 23:26:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:56988 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264628AbUD1D0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 23:26:40 -0400
Date: Tue, 27 Apr 2004 20:25:20 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: gregkh <greg@kroah.com>
Cc: raven@themaw.net, pj@sgi.com, erdi.chen@digeo.com, davem@redhat.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: sparc64 2.6.6-rc2-mm2 build busted: usb/core/hub.c hubstatus
Message-Id: <20040427202520.017e4591.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0404280111430.2125@skynet>
References: <20040426204947.797bd7c2.pj@sgi.com>
	<Pine.LNX.4.58.0404271248250.8094@wombat.indigo.net.au>
	<Pine.LNX.4.58.0404272234320.1547@donald.themaw.net>
	<Pine.LNX.4.58.0404280111430.2125@skynet>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The USB hubstatus part of the patch looked correct to me.
Greg, do you already have a s/hubstatus/devstat/ in hub.c,
near line 1343?

original email:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108303816120001&w=2

Paul, please use diff -u (unified) type diffs in the future.

--
~Randy
