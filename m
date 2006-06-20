Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWFTRIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWFTRIA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 13:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWFTRIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 13:08:00 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:30640 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750749AbWFTRH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 13:07:59 -0400
Date: Tue, 20 Jun 2006 19:07:20 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Steven Rostedt <rostedt@goodmis.org>
cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [Bug 6451] CONFIG_KMOD is not set for x86_64 but is set to Y
 for i386 and other archs
In-Reply-To: <Pine.LNX.4.58.0606201159260.32334@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.64.0606201847560.17704@scrub.home>
References: <200606201433.k5KEXbhX003862@fire-2.osdl.org>
 <a06230977c0bdc14545ff@[129.98.90.227]> <Pine.LNX.4.58.0606201159260.32334@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 20 Jun 2006, Steven Rostedt wrote:

> Now, the point you _could_ have made, is that the Help on KMOD says
> 
>    "If unsure, say Y"
> 
> Which to me _is_ a bug.  I just hate it when the default doesn't match the
> recommended comment of any config option.

What I personally hate even more are help texts, that want me to say Y, 
but don't really explain why (and even worse are options which set the 
default to y without explanation).
This is a somewhat common boilerplate which has it's origin in the old 
config help files and has been copied everywhere. A good help text should 
explain what it does, when the option is enabled and then can give
specific advice, who should enable it.

bye, Roman
