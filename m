Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWEVVz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWEVVz7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 17:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWEVVz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 17:55:59 -0400
Received: from xenotime.net ([66.160.160.81]:21713 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751220AbWEVVz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 17:55:59 -0400
Date: Mon, 22 May 2006 14:58:32 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, wim@iguana.be
Subject: Re: [PATCH 1/14/] Doc. sources: expose watchdog
Message-Id: <20060522145832.ce45807a.rdunlap@xenotime.net>
In-Reply-To: <20060522144347.07b08a8c.akpm@osdl.org>
References: <20060521205810.64b631e2.rdunlap@xenotime.net>
	<20060522144347.07b08a8c.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2006 14:43:47 -0700 Andrew Morton wrote:

> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> >
> >  Documentation/watchdog/pcwd-watchdog.txt |   73 -------------------------------
> >   Documentation/watchdog/watchdog-api.txt  |   17 -------
> >   Documentation/watchdog/watchdog-simple.c |   15 ++++++
> >   Documentation/watchdog/watchdog-test.c   |   68 ++++++++++++++++++++++++++++
> >   Documentation/watchdog/watchdog.txt      |   23 ---------
> 
> Wouldn't it be better to move all the .c files into a new directory? 
> Documentation/src or something?

I dunno.  I like using multiple subdirectories (like watchdog/,
laptop/, block/, etc.) and not cluttering up Documentation/
with them.

Anybody else have preferences?

---
~Randy
