Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266528AbUBLSZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 13:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266522AbUBLSZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 13:25:50 -0500
Received: from cs24243203-239.austin.rr.com ([24.243.203.239]:44044 "EHLO
	raptor.int.mccr.org") by vger.kernel.org with ESMTP id S266528AbUBLSZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 13:25:50 -0500
Date: Thu, 12 Feb 2004 12:25:45 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] get_unmapped_area() change -> non booting machine
Message-ID: <387610000.1076610345@[10.1.1.5]>
In-Reply-To: <Pine.LNX.4.58.0402121014330.5816@home.osdl.org>
References: <1076384799.893.5.camel@gaston>
 <Pine.LNX.4.58.0402100814410.2128@home.osdl.org>
 <20040210173738.GA9894@mail.shareable.org>
 <20040213002358.1dd5c93a.ak@suse.de> <20040212100446.GA2862@elte.hu>
 <Pine.LNX.4.58.0402120833000.5816@home.osdl.org>
 <339500000.1076605352@[10.1.1.5]>
 <Pine.LNX.4.58.0402120912430.5816@home.osdl.org>
 <362010000.1076607103@[10.1.1.5]>
 <Pine.LNX.4.58.0402121014330.5816@home.osdl.org>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, February 12, 2004 10:19:21 -0800 Linus Torvalds
<torvalds@osdl.org> wrote:

> Well, the _common_ case at least for the loader is that the "top of the 
> hole" is actually the stack. So the above would _really_ suck, and crash 
> pretty much immediately ;)

Hmm, good point.  My mental image of the address space tagged the section
at TASK_UNMAPPED_BASE as already allocated.

Dave McCracken

