Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265529AbTGCHXo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 03:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbTGCHXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 03:23:44 -0400
Received: from air-2.osdl.org ([65.172.181.6]:696 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265529AbTGCHXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 03:23:43 -0400
Date: Thu, 3 Jul 2003 00:38:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make ksoftirqd a normal per-cpu variable.
In-Reply-To: <20030703062227.5BAC32C04B@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0307030035420.8776-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 Jul 2003, Rusty Russell wrote:
>
> Linus, please apply.  Small diff overlap with previous patch, and next
> patch.

This arrived in the wrong order, and because it was dependent on another 
patch, and there was no explicit ordering, it didn't apply.

If you have interdependent patches, PLEASE PLEASE PLEASE make that very 
clear in the subject line. Make it say something like

	[PATCH 2/2] Make ksoftirqd a normal per-cpu variable

and then call the patch it depends on "[PATCH 1/2] xxxx"

(Even if they don't necessarily depend on each other, if you have tested
them in some order this is a good idea. They may have dependencies that
you didn't think of).

		Linus

