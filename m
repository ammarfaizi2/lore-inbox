Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbTDGChg (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 22:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTDGChg (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 22:37:36 -0400
Received: from air-2.osdl.org ([65.172.181.6]:51146 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263200AbTDGChe (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 22:37:34 -0400
Message-ID: <33182.4.64.238.61.1049683748.squirrel@webmail.osdl.org>
Date: Sun, 6 Apr 2003 19:49:08 -0700 (PDT)
Subject: Re: Wanted: a limit on kernel log buffer size
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <76306.1226@compuserve.com>
In-Reply-To: <200304062137_MC3-1-3346-A97E@compuserve.com>
References: <200304062137_MC3-1-3346-A97E@compuserve.com>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11 [cvs])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Some people (who will mercifully go unnamed) just will _not_
> read the documentation, and set the kernel log buffer shift
> to 31 on a 256MB machine.  This attempt to allocate 2GB of memory
> for the buffer results in an unbootable kernel.
>
>  Suggestions?

This is a multi-part answer.  Say, 5 parts.

a.  If someone won't read the help text, how can we help them?

b.  If we make a 2 GB log buffer size a compile-time error, will
they read that?

c.  If we make it a compile-time warning, will they read that?

d.  What limit(s) do you suggest?  I can try to add some limits.

e.  This kind of config limiting should be done in the config system IMO.
I've asked Roman for that capability....

~Randy



