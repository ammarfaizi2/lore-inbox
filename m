Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbTCKD20>; Mon, 10 Mar 2003 22:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262803AbTCKD20>; Mon, 10 Mar 2003 22:28:26 -0500
Received: from mail.gmx.de ([213.165.65.60]:19933 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262789AbTCKD20>;
	Mon, 10 Mar 2003 22:28:26 -0500
Message-Id: <5.2.0.9.2.20030311043844.00ca5e58@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Tue, 11 Mar 2003 04:43:39 +0100
To: rwhron@earthlink.net
From: Mike Galbraith <efault@gmx.de>
Subject: Re: scheduler starvation running irman with 2.5.64bk2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030311024629.GA391@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:46 PM 3/10/2003 -0500, rwhron@earthlink.net wrote:
> > The only difference I see is that reniced task wasn't starved with this
> > kernel... wonder what the difference is.
>
>One more thing.  After <ctrl c> interrupting irman process load,
>ssh into the box works.

Yup.  It should also work fine if you renice the shell you run irman from 
to a low enough priority.  Anyhoo, we definitely were experiencing the same 
exact problem, as was Con with contest. Mission accomplished.  I'm off to 
fiddle with Jim Houston's patch until Ingo does his magic :)

         -Mike 

