Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbTDJSR6 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 14:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264152AbTDJSR6 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 14:17:58 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:898 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264151AbTDJSR5 (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 14:17:57 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304101832.h3AIW4iU025549@81-2-122-30.bradfords.org.uk>
Subject: Re: kernel support for non-English user messages
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 10 Apr 2003 19:32:04 +0100 (BST)
Cc: Riley@Williams.Name (Riley Williams), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0304101033030.8329-100000@home.transmeta.com> from "Linus Torvalds" at Apr 10, 2003 10:35:36 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The road to hell is paved with good intentions. This is one of those "good 
> intentions" things - it sounds like it's a nice helper thing, but it's 
> nothing but a load of maintenance headaches and causes horrible printout 
> headaches.

The best option might be simply to document things like error messages
in more detail, (and translate that documentation into as many
languages as possible).

For example, when the IDE code started outputting debug info for a
feature that wasn't implemented on a lot of older drives, (around
2.4.20), there were _loads_ of posts asking what the error meant, and
whether it was something to worry about - a simple

printk ("This is not a critical error");

would have saved a lot of time :-), (note, this isn't a criticism of
the IDE maintainers - it's not practical, or helpful to make _every_
error message verbose, but if it had been documented somewhere, it
would have been useful).

I suggest we introduce a 'grepme' file in the top level of the kernel
source distribution which, as the name suggests, is the first place to
look for whatever-you-were-going-to-post-to-LKML-about.  I volunteer
to maintain such a 'grepme' file if you'll aprove the idea, Linus?

John.
