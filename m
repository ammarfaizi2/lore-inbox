Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263362AbSKVLDq>; Fri, 22 Nov 2002 06:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbSKVLDq>; Fri, 22 Nov 2002 06:03:46 -0500
Received: from pop.gmx.de ([213.165.65.60]:64141 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263362AbSKVLDp>;
	Fri, 22 Nov 2002 06:03:45 -0500
Message-Id: <5.1.1.6.2.20021122120405.00c236e8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Fri, 22 Nov 2002 12:07:36 +0100
To: jim.houston@attbi.com, linux-kernel@vger.kernel.org
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.47 scheduler problems?
Cc: riel@conectiva.com.br
In-Reply-To: <3DDDC37F.5AC219D5@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:41 AM 11/22/2002 -0500, Jim Houston wrote:
>Hi Mike, Rik, Everyone,
>
>The O(1) schedule just isn't fair.  It will run a subset
>of the runable processes excluding the rest.  See my earlier
>emails for the details.
>
>I had been working on a fix for this but got distracted
>by Posix timers.  I still hope to get back to it.
>
>My patch is here:
>http://marc.theaimsgroup.com/?l=linux-kernel&m=103508412423719&w=2

In a brief test, this seems to cure my problem.

>It fixes fairness but breaks nice(2). Rik van Riel has a
>patch here which builds on my patch which fixes this:
>http://marc.theaimsgroup.com/?l=linux-kernel&m=103651801424031&w=2

(I haven't test this one yet)

>I just gave this a spin with.  The patches still apply cleanly
>to linux-2.5.48 and it seems well behaved:-)

It seems a little choppy still for a not swapping load, but greatly improved.

Thanks!

         -Mike 

