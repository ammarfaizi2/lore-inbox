Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbTD1BE3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 21:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbTD1BE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 21:04:29 -0400
Received: from user72.209.42.38.dsli.com ([209.42.38.72]:14391 "EHLO
	nolab.conman.org") by vger.kernel.org with ESMTP id S262706AbTD1BE2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 21:04:28 -0400
Date: Sun, 27 Apr 2003 21:16:44 -0400 (EDT)
From: Mark Grosberg <mark@nolab.conman.org>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
In-Reply-To: <20030428005925.GC27729@work.bitmover.com>
Message-ID: <Pine.BSO.4.44.0304272114560.23296-100000@kwalitee.nolab.conman.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 27 Apr 2003, Larry McVoy wrote:

> If you do this, _please_ make it compat with NT.

Actually, I thought about this. My first thought is this could benefit
WINE running on Linux. Then (not like I'm a Wine expert by any means) I
figured it might be an issue as far as having to do some preliminary
wineserver setup work (if anybody on this list knows better than me, speak
up!)

But yeah, basically, something similar to NT's CreateProcess(). For the
cases where the one-step process creation is sufficient.

L8r,
Mark G.


