Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbSLaOZs>; Tue, 31 Dec 2002 09:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbSLaOZs>; Tue, 31 Dec 2002 09:25:48 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:33672 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263039AbSLaOZr>;
	Tue, 31 Dec 2002 09:25:47 -0500
Date: Tue, 31 Dec 2002 20:05:19 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Andy Pfiffer <andyp@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       wa@almesberger.net
Subject: Re: [PATCH][CFT] kexec (rewrite) for 2.5.52
Message-ID: <20021231200519.A2110@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <m1smwql3av.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1smwql3av.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, Dec 22, 2002 at 04:07:52AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 22, 2002 at 04:07:52AM -0700, Eric W. Biederman wrote:
> 
> I have recently taken the time to dig through the internals of
> kexec to see if I could make my code any simpler and have managed
> to trim off about 100 lines, and have made the code much more
> obviously correct.
> 
> Anyway, I would love to know in what entertaining ways this code blows
> up, or if I get lucky and it doesn't.  I probably will not reply back
> in a timely manner as I am off to visit my parents, for Christmas and
> New Years.  
> 

The good news is that it worked for me. Not only that, I have just 
managed to get lkcd to save a dump in memory and then write it out 
to disk after a kexec soft boot ! I haven't tried real panic cases yet 
(which probably won't work rightaway :) ) and have testing and 
tuning to do. But kexec seems to be looking good.

Have a wonderful new year.

Regards
Suparna
