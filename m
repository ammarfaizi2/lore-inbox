Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751663AbWEPQsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbWEPQsl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbWEPQsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:48:40 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:29609 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751663AbWEPQsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:48:40 -0400
Date: Tue, 16 May 2006 12:48:34 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: LKML <linux-kernel@vger.kernel.org>
cc: Suspend2-users@lists.suspend2.net
Subject: Re: Over-heating CPU on 2.6.16 with Thinkpad G41
In-Reply-To: <Pine.LNX.4.58.0605160339340.5333@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605161246220.14877@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605160253010.4283@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605160339340.5333@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 May 2006, Steven Rostedt wrote:

>
> On Tue, 16 May 2006, Steven Rostedt wrote:
>
> >
> > Hmm, could this be the "acpi_sleep=s3_bios" that Suspend2 asks for?
> > I haven't removed that option yet.
>
> OK, removing this option seems to make my machine run cool again.  So I
> guess my bios doesn't support s3 very well.
>

Darn, I just booted with the Suspend2 patches back in (without the
"s3_bios" option) and my machine is again overheating. Pulled out the
patches again, rebooted and my laptop is fine.

Looks like I can't use Suspend2 with this laptop.  Too bad.

-- Steve

