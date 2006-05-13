Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWEMWb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWEMWb6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 18:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWEMWb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 18:31:58 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:34264 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932371AbWEMWb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 18:31:57 -0400
Date: Sat, 13 May 2006 18:31:40 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] unnecessary long index i in sched
In-Reply-To: <Pine.LNX.4.61.0605132325070.11638@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.58.0605131830460.2208@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605131311590.27751@gandalf.stny.rr.com>
 <Pine.LNX.4.61.0605132325070.11638@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 13 May 2006, Jan Engelhardt wrote:

> >
> >Unless we expect to have more than 4294967295 CPUs, there's no reason to
> >have 'i' as a long long here.
> >
> If declaring it as int, your number should read as 2147483647. :)
>

You know that as soon as I sent this email, I knew some wise ass was going
to respond with that!

;)

-- Steve

