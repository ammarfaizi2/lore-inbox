Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbSLHJMx>; Sun, 8 Dec 2002 04:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264962AbSLHJMx>; Sun, 8 Dec 2002 04:12:53 -0500
Received: from ip68-4-86-174.oc.oc.cox.net ([68.4.86.174]:1939 "EHLO
	ip68-4-86-174.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S264711AbSLHJMx>; Sun, 8 Dec 2002 04:12:53 -0500
Date: Sun, 8 Dec 2002 01:20:32 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Joseph D. Wagner" <wagnerjd@prodigy.net>
Cc: "'rtilley'" <rtilley@vt.edu>,
       Linux Kernel Development List <linux-kernel@vger.kernel.org>
Subject: Re: lilo append mem problem in 2.4.20
Message-ID: <20021208092032.GD17498@ip68-4-86-174.oc.oc.cox.net>
References: <3DFDE59F@zathras> <000c01c29e90$bae7d530$5b1c1c43@joe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000c01c29e90$bae7d530$5b1c1c43@joe>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2002 at 02:06:34AM -0600, Joseph D. Wagner wrote:
> > Compaq proliant 5000 4 way Pentium Pro
> 
> You mean Quad processors?  Wow!
> 
> > I used RH's 686-smp kernel config file to build the
> > 2.4.20-ac1 kernel. I turned High Mem support off as
> > I don't think 1 GB is high mem... is it?
> 
> Actually, anything over 896 or so MB is considered High Mem.  Don't ask me
> why.  I didn't write the code.  If I did, I would have used a nice round
> number.
> 
> IN OTHER WORDS, TURN HIGH MEM SUPPORT BACK ON!

The original poster should still have access to 896MB of RAM even with
highmem off. Something else is actually wrong. (I don't have any useful
ideas for troubleshooting it though.)

> Now, this part is just my guess, but try compiling the kernel for 586-smp
> instead of a 686-smp.  IMHO, the documentation isn't really clear about
> exactly which processor crosses the threshold, and Intel's naming convention
> doesn't help either.
> 
> But I could be wrong.

You could say the difference between "586" and "686" is essentially the
difference between the original Pentium and the Pentium Pro.

Thus the original Pentium, and its variant the Pentium MMX, are 586.
The Pentium Pro, and its variants the Pentium II and III (and their
Celeron variants too) are 686. The Pentium IV identifies itself as
a 1586 (as has been mentioned on this list in the past, it's a bad
pun involving roman numerals), but Linux considers that to be 686.

I hope that helps.

-Barry K. Nathan <barryn@pobox.com>
