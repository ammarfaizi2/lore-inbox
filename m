Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136437AbRASBDq>; Thu, 18 Jan 2001 20:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136332AbRASBDg>; Thu, 18 Jan 2001 20:03:36 -0500
Received: from Cantor.suse.de ([194.112.123.193]:63503 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S136536AbRASBD3>;
	Thu, 18 Jan 2001 20:03:29 -0500
Date: Fri, 19 Jan 2001 01:51:01 +0100
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Mike Kravetz <mkravetz@sequent.com>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: multi-queue scheduler update
Message-ID: <20010119015101.A6687@gruyere.muc.suse.de>
In-Reply-To: <20010118155311.B8637@w-mikek.des.sequent.com> <20010119012616.D32087@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010119012616.D32087@athlon.random>; from andrea@suse.de on Fri, Jan 19, 2001 at 01:26:16AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001 at 01:26:16AM +0100, Andrea Arcangeli wrote:
> I remeber the O(1) scheduler from Davide Libenzi was beating the mainline O(N)
> scheduler with over 7 tasks in the runqueue (actually I'm not sure if the
> number was 7 but certainly it was under 10). So if you also use a O(1)
> scheduler too as I guess (since you have a chance to run fast on the lots of
> tasks running case) the most interesting thing is how you score with 2/4/8
> tasks in the runqueue (I think the tests on the O(1) scheduler patch was done
> at max on a 2-way SMP btw). (the argument for which Davide's patch wasn't
> included is that most machines have less than 4/5 tasks in the runqueue at the
> same time)

They seem to have tried that in a separate patch:
http://lse.sourceforge.net/scheduling/PrioScheduler.html

Very nice literate programming style btw @-)


-Andi 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
