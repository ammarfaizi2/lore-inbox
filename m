Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030439AbWAGNzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbWAGNzw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 08:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbWAGNzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 08:55:52 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:4494 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1030439AbWAGNzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 08:55:51 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm 1/2] swsusp: low level interface
Date: Sat, 7 Jan 2006 14:57:53 +0100
User-Agent: KMail/1.9
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
References: <200601071328.39707.rjw@sisk.pl> <200601071336.59242.rjw@sisk.pl> <20060107052049.43ded9fd.akpm@osdl.org>
In-Reply-To: <20060107052049.43ded9fd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601071457.54112.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 7 January 2006 14:20, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> >  This patch introduces the low level interface that can be used for handling
> >  the snapshot of the system memory by the in-kernel swap-writing/reading
> >  code of swsusp and the userland interface code (to be introduced shortly).
> 
> It's a bit sad the way this code goes poking around in swap internals.

Actually swsusp does it anyway ...

> Would it be neater to create a few helper functions over in mm/ and call
> them?

... but of course it can be changed as you say.  I'll try to prepare something
like that.

> This patch needs pretty much all of its inlines removed.  It's way over the
> top.

I'll fix that.

Rafael
