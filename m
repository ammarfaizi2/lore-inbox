Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbTEVPzF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbTEVPzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:55:05 -0400
Received: from pop.gmx.de ([213.165.64.20]:11727 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261998AbTEVPzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:55:03 -0400
Message-Id: <5.2.0.9.2.20030522173254.00cd21b8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 22 May 2003 18:12:37 +0200
To: Valdis.Kletnieks@vt.edu
From: Mike Galbraith <efault@gmx.de>
Subject: Re: web page on O(1) scheduler 
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200305221447.h4MElAKx003511@turing-police.cc.vt.edu>
References: <Your message of "Thu, 22 May 2003 07:52:44 +0200." <5.2.0.9.2.20030522063421.00cc3e90@pop.gmx.net>
 <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net>
 <5.2.0.9.2.20030521111037.01ed0d58@pop.gmx.net>
 <5.2.0.9.2.20030522063421.00cc3e90@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:47 AM 5/22/2003 -0400, Valdis.Kletnieks@vt.edu wrote:
>On Thu, 22 May 2003 07:52:44 +0200, Mike Galbraith said:
>
> > It does consider cpu usage though.  Your run history is right there in 
> your
> > accumulated sleep_avg.  Unfortunately (in some ways, fortunate in others..
> > conflict) that information can be diluted down to nothing instantly by new
> > input from one wakeup.
>
>Maybe there should be a scheduler tunable that says how much it should be
>diluted?

I hope not.  Once you use a knob, you _have_ to use it again when you 
change workloads.

         -Mike 

