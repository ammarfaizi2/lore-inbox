Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266177AbUFUJo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266177AbUFUJo4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 05:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266176AbUFUJo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 05:44:56 -0400
Received: from stogtw01.enlight.net ([212.209.183.10]:42252 "EHLO
	stodns01.enlightnet.local") by vger.kernel.org with ESMTP
	id S266177AbUFUJoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 05:44:55 -0400
Date: Mon, 21 Jun 2004 11:44:48 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.local
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6] Fix smbfs readdir oops
In-Reply-To: <Pine.LNX.4.58.0406201834390.3273@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.44.0406211055340.19689-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Jun 2004 09:44:53.0176 (UTC) FILETIME=[6728B380:01C45774]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2004, Zwane Mwaikambo wrote:

> This has been reported a couple of times and is consistently causing some
> folks grief, so Urban, would you mind terribly if i send this patch to at
> least clear current bug reports. If there is additional stuff you want
> ontop of this let me know and i can send a follow up patch.

I should read all my mail before replying. Yes, this is a problem for 
people and I was thinking the same thing that we should get this in now 
and fix the remaining problem later.

One question:
Why do you need conn_complete? Isn't "server->state == CONN_VALID" good
enough?

And are you still working on fixing the remaining "multiple-ls" problem?
(The one where one ls would work and the other return an error).
Or is that fixed in this version?

/Urban

