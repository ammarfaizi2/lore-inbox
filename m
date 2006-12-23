Return-Path: <linux-kernel-owner+w=401wt.eu-S1753526AbWLWMoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbWLWMoy (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 07:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753529AbWLWMoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 07:44:54 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:46628 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbWLWMox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 07:44:53 -0500
Date: Sat, 23 Dec 2006 07:44:29 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] change WARN_ON back to "BUG: at ..."
In-Reply-To: <20061223110350.GA25279@elte.hu>
Message-ID: <Pine.LNX.4.58.0612230741500.14326@gandalf.stny.rr.com>
References: <20061221124327.GA17190@elte.hu> <458AD71D.2060508@goop.org>
 <20061221235732.GA32637@elte.hu> <20061222120422.eb28953b.akpm@osdl.org>
 <1166839610.1573.20.camel@localhost.localdomain> <20061223110350.GA25279@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Dec 2006, Ingo Molnar wrote:

>
> i can whip up a patch for any of these conversions, but i dont think we
> need this flux right now.
>

I agree, it's not needed right now.  But making BUG_ON panic seems to be a
good idea, but if you do make that change (and even if you don't), could
you please add the dump_stack into panic (like you have in -rt)?  Thanks!

-- Steve

