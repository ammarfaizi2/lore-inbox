Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbTFTKws (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 06:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbTFTKws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 06:52:48 -0400
Received: from pop.gmx.net ([213.165.64.20]:62623 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262830AbTFTKwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 06:52:47 -0400
Message-Id: <5.2.0.9.2.20030620130623.00ceff70@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 20 Jun 2003 13:09:37 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] sleep_decay for interactivity 2.5.72 - testers 
  needed
Cc: Andreas Boman <aboman@midgaard.us>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200306201229.55425.kernel@kolivas.org>
References: <1056058342.917.69.camel@asgaard.midgaard.us>
 <5.2.0.9.2.20030619171843.02299e00@pop.gmx.net>
 <200306200250.01865.kernel@kolivas.org>
 <1056058342.917.69.camel@asgaard.midgaard.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:29 PM 6/20/2003 +1000, Con Kolivas wrote:
>On Fri, 20 Jun 2003 07:32, Andreas Boman wrote:
> >
> > Basicly, for normal usage this kernel is acting *very* well here.
>
>Great! Thanks for doing this testing. I've attached a patch with the updated
>figures and cc'ed lkml for others to test.

Thud is still much more effective at starvation than stock (zero decay 
during run phase), and a parallel kernel build still goes to 
max-interactive virtually instantly.

         -Mike 

