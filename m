Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUGGGM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUGGGM7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 02:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbUGGGM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 02:12:59 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:5328 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S264917AbUGGGM6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 02:12:58 -0400
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
From: Ray Lee <ray-lk@madrabbit.org>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, tomstdenis@yahoo.com,
       eger@havoc.gtf.org, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <orisd0qrxi.fsf@livre.redhat.lsd.ic.unicamp.br>
References: <1089165901.4373.175.camel@orca.madrabbit.org>
	 <20040707030227.GE12308@parcelfarce.linux.theplanet.co.uk>
	 <orisd0qrxi.fsf@livre.redhat.lsd.ic.unicamp.br>
Content-Type: text/plain
Organization: http://madrabbit.org/
Message-Id: <1089180777.4373.186.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 06 Jul 2004 23:12:57 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-06 at 22:58, Alexandre Oliva wrote:
> Are you sure?  I've seen K&R C compilers for 32-bit platforms in which
> 0xdeadbeef had type *signed* int, as opposed to unsigned int.

K&R pre-ANSI (i.e., K&R first edition) allowed this. K&R second edition,
a.k.a. ANSI C clarifies this substantially, as per my previous two
messages on the topic.

> I thought the preference for an unsigned type in this case was
> introduced in ISO C90, but it might as well have been a bug in that
> compiler.  Although I'm told other compilers display similar behavior.

File a bug.

Ray

