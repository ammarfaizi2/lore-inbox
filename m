Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272752AbTHPGKb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 02:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272748AbTHPGKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 02:10:31 -0400
Received: from pop.gmx.net ([213.165.64.20]:62386 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272752AbTHPGK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 02:10:27 -0400
Message-Id: <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sat, 16 Aug 2003 08:14:36 +0200
To: Jamie Lokier <jamie@shareable.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Scheduler activations (IIRC) question
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>
In-Reply-To: <20030816005408.GA21356@mail.jlokier.co.uk>
References: <20030815235431.GT1027@matchmail.com>
 <200308160149.29834.kernel@kolivas.org>
 <20030815230312.GD19707@mail.jlokier.co.uk>
 <20030815235431.GT1027@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:54 AM 8/16/2003 +0100, Jamie Lokier wrote:
[...]

>None of these will work well if "wakee" tasks are able to run
>immediately after being woken, before "waker" tasks get a chance to
>either block or put the wakees back to sleep.

Sounds like another scheduler class (SCHED_NOPREEMPT) would be required.

         -Mike 

