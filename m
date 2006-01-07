Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWAGMEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWAGMEi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 07:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbWAGMEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 07:04:38 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:12449 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932348AbWAGMEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 07:04:38 -0500
Date: Sat, 7 Jan 2006 07:04:29 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] protect remove_proc_entry
In-Reply-To: <20060107033637.458c4716.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0601070703310.1483@gandalf.stny.rr.com>
References: <1135973075.6039.63.camel@localhost.localdomain>
 <1135978110.6039.81.camel@localhost.localdomain> <20060107033637.458c4716.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 7 Jan 2006, Andrew Morton wrote:

>
> Aren't there other places where we need to take this lock?  Code which
> traverses that list, code which adds things to it?
>

Yeah, that patch was just a quick fix.  I'll look more into that on
Monday. (My wife has too many chores for me this weekend ;)

-- Steve
