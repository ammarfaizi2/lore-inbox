Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280203AbRKEE4Q>; Sun, 4 Nov 2001 23:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280214AbRKEE4H>; Sun, 4 Nov 2001 23:56:07 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:23046 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S280212AbRKEE4C>;
	Sun, 4 Nov 2001 23:56:02 -0500
Message-Id: <5.1.0.14.0.20011105154947.01f6fec0@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 05 Nov 2001 15:55:58 +1100
To: Alexander Viro <viro@math.psu.edu>
From: Stuart Young <sgy@amc.com.au>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0111042304270.23204-100000@weyl.math.psu.edu
 >
In-Reply-To: <5.1.0.14.0.20011105144855.01f83310@mail.amc.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:05 PM 4/11/01 -0500, Alexander Viro wrote:


>On Mon, 5 Nov 2001, Stuart Young wrote:
>
> > Any reason we can't move all the process info into something like
> > /proc/pid/* instead of in the root /proc tree?
>
>Thanks, but no thanks.  If we are starting to move stuff around, we
>would be much better off leaving in /proc only what it was supposed
>to contain - per-process information.

That's fair.. so (this is all speculation of course) move everything else 
but process info out of there? I could handle that, makes sense, long as we 
had some backward "transitional" interface, that warned about using old 
interfaces. Only question is, where would we put this information in the 
file system tree?


AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

