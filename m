Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263689AbTIHWaL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbTIHWaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:30:11 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:38921 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263689AbTIHW2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:28:51 -0400
Subject: Re: Use of AI for process scheduling
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F5CD863.4020605@techsource.com>
References: <3F5CD863.4020605@techsource.com>
Content-Type: text/plain
Message-Id: <1063060111.1224.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 00:28:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-08 at 21:28, Timothy Miller wrote:

> Basically, we need to write and install into the kernel an AI engine
> which uses user feedback about the "feel" of the system to adjust
> heuristics dynamically.  For instance, if the user sees that the system
> is misbehaving, they can pause the system in the kernel debugger,
> examine process priorities, and indicate what "outputs" from the AI
> engine are wrong.  It then learns from that.  Heuristics can be tweaked
> until things run as desired.  At that point, scheduler developers trade
> emails in the AI heuristic language.

I'm no kernel expert but I think that doing what you suggest would take
an enormous amount of time and resources to do. Also, the scheduler must
be a real-time piece of software, and needs to take decisions as fast
and as accurately as possible. I think that implementing an IA-like
engine would take an great deal of resources. By the time the IA-like
scheduler has taken its decision, the whole world could have changed
since.

