Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131649AbRBFANL>; Mon, 5 Feb 2001 19:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131997AbRBFANB>; Mon, 5 Feb 2001 19:13:01 -0500
Received: from 200-221-84-35.dsl-sp.uol.com.br ([200.221.84.35]:786 "HELO
	dumont.rtb.ath.cx") by vger.kernel.org with SMTP id <S131649AbRBFAMu>;
	Mon, 5 Feb 2001 19:12:50 -0500
Date: Mon, 5 Feb 2001 22:12:45 -0200
From: Rogerio Brito <rbrito@iname.com>
To: linux-kernel@vger.kernel.org
Subject: What is the difference between buffers and cached? (was: Re: 2.4.x Shared memory question)
Message-ID: <20010205221245.B9945@iname.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3A7E49C6.BE283336@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A7E49C6.BE283336@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 04 2001, LA Walsh wrote:
> Another oddity -- I notice things taking alot more memory
> in 2.4.  This coincides with 'top' consistently showing I have 0 shared
> memory.

	AFAIK, the 2.4.0 series does share memory, but it's just the
	counters that are not updated, for they are costly.

>         total:    used:    free:  shared: buffers:  cached:
> Mem:  525897728 465264640 60633088        0 82145280 287862784
> Swap: 270909440        0 270909440

	This is the perfect time to ask one thing that I don't know,
	but that I've tried to find without success: what is the
	difference between "buffers" and "cached"? I'd make the wild
	guess that "buffers" would mean any types of buffers that the
	kernel maintains, while "cached" would have something to do
	with cached disk blocks...

	Are these guesses correct or completely, way off?


	Thanks for any hints, Roger...

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogerio Brito - rbrito@iname.com - http://www.ime.usp.br/~rbrito/
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
