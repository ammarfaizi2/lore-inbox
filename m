Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbTJ2J6G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 04:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTJ2J6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 04:58:06 -0500
Received: from mx1.elte.hu ([157.181.1.137]:24995 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261838AbTJ2J6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 04:58:04 -0500
Date: Wed, 29 Oct 2003 10:55:38 +0100
From: Kovacs Richard <krichard@elte.hu>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI suspend does not work when X is running
Message-ID: <20031029095537.GA1625@login.elte.hu>
Reply-To: krichard@elte.hu
References: <20031028102944.GA5230@login.elte.hu> <Pine.LNX.4.33.0310280852350.7139-100000@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0310280852350.7139-100000@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
Organization: Eotvos Lorand University, Budapest, Hungary
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 28 Patrick Mochel wrote:
> > I think it might have something to do with the modules
> > agpgart,
> > intel-agp,
> > i830.
> Please try unloading as many of those modules as you can before
> suspending, and re-inserting them after you resume.

Okay. What I've done is the following. Unloaded every module except
the ones above before even trying to suspend. Then unloaded the above
modules during suspend, so basically no modules should have been
loaded before shutting down. The result: the same. Blank screen has
not appeared now, I only got the double fault, that is attached to my
previous mail.

In 2.4.22 swsusp works fine for me.


So what's the next step I should do to investigate?


Thx,

Richard
