Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265851AbTFSRMp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 13:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265850AbTFSRMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 13:12:45 -0400
Received: from pop.gmx.net ([213.165.64.20]:2507 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265851AbTFSRMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 13:12:44 -0400
Message-Id: <5.2.0.9.2.20030619184906.00cea3c0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 19 Jun 2003 19:31:07 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] sleep_decay for interactivity 2.5.72 - testers 
  needed
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andreas Boman <aboman@midgaard.us>
In-Reply-To: <200306200202.37745.kernel@kolivas.org>
References: <5.2.0.9.2.20030619171843.02299e00@pop.gmx.net>
 <5.2.0.9.2.20030619171843.02299e00@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:02 AM 6/20/2003 +1000, Con Kolivas wrote:
>On Fri, 20 Jun 2003 01:47, Mike Galbraith wrote:
> > At 12:05 AM 6/20/2003 +1000, Con Kolivas wrote:
> > >Testers required. A version for -ck will be created soon.
> >
> > That idea definitely needs some refinement.
>
>Actually no it needs a bugfix even more than a refinement!
>
>The best_sleep_decay should be 60, NOT 60*Hz

Ok.  Now it acts as you described.

thud is also now THUD though, and a parallel kernel build goes insane 
pretty much instantly.  On the bright side, process_load seems to have lost 
it's ability to crawl up (under X) and starve new processes forever.

         -Mike 

