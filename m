Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265081AbUBIMfK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 07:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265105AbUBIMfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 07:35:10 -0500
Received: from mail.shareable.org ([81.29.64.88]:10624 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265081AbUBIMfF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 07:35:05 -0500
Date: Mon, 9 Feb 2004 12:33:55 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ross Dickson <ross@datscreative.com.au>
Cc: linux-kernel@vger.kernel.org, Ian Kumlien <pomac@vapor.com>,
       Jesse Allen <the3dfxdude@hotmail.com>
Subject: Re: Nforce2 apic timer ack delay
Message-ID: <20040209123355.GB1738@mail.shareable.org>
References: <200312211917.05928.ross@datscreative.com.au> <20040207145544.GC17015@mail.shareable.org> <200402082141.09693.ross@datscreative.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402082141.09693.ross@datscreative.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Dickson wrote:
> I was just writing you to tell you how well it prevented lockups
> when my system experienced a hard lockup in a slightly different
> form. Firstly mplayer bailed complaining about misuse of cpu ram
> etc, which is an abnormal failure for this system. I then swapped
> desktops back to continue my email and then no mouse or anything
> else just like one of the original hard lockups.

Well, that's a different form of lockup so it might be a different
culprit.  What was the mplayer error?

> A bit early to draw conclusions but could it be that the bios also
> executes a hlt instruction in a System Management Interrupt??
> Perhaps on detecting a hot cpu or something??

Perhaps.  Are you using APM or ACPI?  I think they override
"idle=poll" and call into the BIOS for idling.

-- Jamie
