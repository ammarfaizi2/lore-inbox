Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWEJS2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWEJS2C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 14:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWEJS2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 14:28:02 -0400
Received: from hera.kernel.org ([140.211.167.34]:57534 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751494AbWEJS2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 14:28:00 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
Date: Wed, 10 May 2006 11:27:30 -0700
Organization: OSDL
Message-ID: <20060510112730.2f462289@localhost.localdomain>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com>
	<1147257266.17886.3.camel@localhost.localdomain>
	<1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	<1147273787.17886.46.camel@localhost.localdomain>
	<1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	<Pine.LNX.4.58.0605101116590.5532@gandalf.stny.rr.com>
	<20060510162404.GR3570@stusta.de>
	<Pine.LNX.4.58.0605101240190.20305@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0605101327380.20305@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1147285651 8997 10.8.0.54 (10 May 2006 18:27:31 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 10 May 2006 18:27:31 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2006 13:45:58 -0400 (EDT)
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Oh fsck! gcc is hosed. I just tried out this BS module:

Read the GCC bug report.
	http://gcc.gnu.org/bugzilla/show_bug.cgi?id=5035

It seems it is one of those "it too hard to fix, so we aren't going to"
blow offs.
