Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWDUSnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWDUSnA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 14:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWDUSnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 14:43:00 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:51428 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751347AbWDUSm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 14:42:59 -0400
Subject: Re: kfree(NULL)
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tilman Schmidt <tilman@imap.cc>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1145642459.24962.12.camel@localhost.localdomain>
References: <63XWg-1IL-5@gated-at.bofh.it> <63YfP-26I-11@gated-at.bofh.it>
	 <63ZEY-45n-27@gated-at.bofh.it>  <4448F97D.5000205@imap.cc>
	 <1145635403.20843.21.camel@localhost.localdomain>
	 <1145642459.24962.12.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 11:42:56 -0700
Message-Id: <1145644977.20843.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 14:00 -0400, Steven Rostedt wrote:

> [     6491]  c01aafc4 - start_this_handle+0x234/0x4b0
> [     8404]  c01aba66 - do_get_write_access+0x2e6/0x5a0


IMO , these two are overloaded with goto's it makes it hard to know
whats going on .

Daniel

