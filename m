Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270998AbTHKF13 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 01:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271118AbTHKF13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 01:27:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:5858 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270998AbTHKF12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 01:27:28 -0400
Message-Id: <5.2.1.1.2.20030811071606.0197a628@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 11 Aug 2003 07:31:36 +0200
To: Daniel Phillips <phillips@arcor.de>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy  
   ...
Cc: Takashi Iwai <tiwai@suse.de>, Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308102128.49817.phillips@arcor.de>
References: <5.2.1.1.2.20030810182157.019c66c0@pop.gmx.net>
 <5.2.1.1.2.20030810080748.019cb090@pop.gmx.net>
 <5.2.1.1.2.20030810182157.019c66c0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:28 PM 8/10/2003 +0100, Daniel Phillips wrote:

>there's a cap on that.  And anyway, why aren't those kernel threads running
>with realtime priority in the first place?

Good question.  events, kblockd and aio at least look like they should.

>While we're in here: what should be the maximum realtime priority granted 
>to a
>normal user?  It should probably be another adminstrator knob.

That's an easy one.. the top of the SCHED_SOFTRR range ;)

         -Mike 

