Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289611AbSAWBOx>; Tue, 22 Jan 2002 20:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289612AbSAWBOe>; Tue, 22 Jan 2002 20:14:34 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:19972 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S289611AbSAWBOV>;
	Tue, 22 Jan 2002 20:14:21 -0500
Message-Id: <5.1.0.14.0.20020123115902.026be410@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 23 Jan 2002 12:14:18 +1100
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: Possible Idea with filesystem buffering.
Cc: Hans Reiser <reiser@namesys.com>, Rik van Riel <riel@conectiva.com.br>,
        Andreas Dilger <adilger@turbolabs.com>, Shawn Starr <spstarr@sh0n.net>,
        root@chaos.analogic.com, Chris Mason <mason@suse.com>
In-Reply-To: <Pine.LNX.3.95.1020122164209.14535A-100000@chaos.analogic.c
 om>
In-Reply-To: <2116720000.1011733708@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:10 PM 22/01/02 -0500, Richard B. Johnson wrote:
>We need a free-RAM target, possibly based upon a percentage of
>available RAM. The lack of such a target is what causes the
>out-of-RAM condition we have been experiencing. Somebody thought
>that "free RAM is wasted RAM" and the VM has been based upon
>that theory. That theory has been proven incorrect. You need
>free RAM, just like you need "excess horsepower" to make
>automobiles drivable. That free RAM is the needed "rubber-band"
>to absorb the dynamics of real-world systems.

It'd be nice if this cache high/low watermark was adjustable, preferably 
through say the sysctl interface, on a running kernel. This would mean that 
a competent system administrator could tune the system to their needs. A 
decent runscript for a particular program (I'm assuming run as root here) 
could adjust the value to absorb the dynamics of a particular program.


Stuart Young - sgy@amc.com.au
(aka Cefiar) - cefiar1@optushome.com.au

[All opinions expressed in the above message are my]
[own and not necessarily the views of my employer..]

