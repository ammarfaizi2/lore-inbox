Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278320AbRJWWQ2>; Tue, 23 Oct 2001 18:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278351AbRJWWQT>; Tue, 23 Oct 2001 18:16:19 -0400
Received: from grip.panax.com ([63.163.40.2]:785 "EHLO panax.com")
	by vger.kernel.org with ESMTP id <S278320AbRJWWQG>;
	Tue, 23 Oct 2001 18:16:06 -0400
Date: Tue, 23 Oct 2001 18:15:34 -0400
From: Patrick McFarland <unknown@panax.com>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM
Message-ID: <20011023181533.B379@localhost>
Mail-Followup-To: bill davidsen <davidsen@tmr.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011023002702.A2446@localhost> <63kB7.3873$0w5.657641665@newssvr17.news.prodigy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63kB7.3873$0w5.657641665@newssvr17.news.prodigy.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.12 i586
X-Distributed: Join the Effort!  http://www.distributed.net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-Oct-2001, bill davidsen wrote:
> In article <20011023002702.A2446@localhost>,
> Patrick McFarland <unknown@panax.com> wrote:
> | Slightly off topic, but I kinda find it cool that this thread is still going, seeing as I
> | started it on the 15th. =)
> | 
> | Anyhow, have we decided that 2.5 should have the ac-vm or the linus-vm?
> 
> I hope not, the bug-fix and corner case competition is doing good thing
> for VM in both directions. That's healthy.
> 
> What I would like to see is VM moved to a module so you could have
> either, or any of several competing designs which would be bound to
> emerge once there's a neat interface and you can write to that instead
> of trying to understand and hack all the stuff needed now. The effort is
> high and the chance for problems high as well right now, in other words
> a high ratio of implementation to method expertise.
> 
That module idea was mine, btw. Rik will speak up on that too, cause I was talking to him about it. =) I dont like having to run ac just for the better vm engine.

> I also would love to see the dispatcher moved to a module, so people can
> easily play with ideas like the idle process, integrating VM and
> dispatch operation at high memory load, etc.
> 
> Right now you not only need to understand the topic, but the
> implementation. The implementation could be made easier with a clean
> interface and an easy way to load changes for test without compiling a
> kernel.
> 
> <BOOM>
>   Yes, I'm still beating the drum for those modules.
> </BOOM>
> 
> -- 
> bill davidsen <davidsen@tmr.com>
>   His first management concern is not solving the problem, but covering
> his ass. If he lived in the middle ages he'd wear his codpiece backward.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Patrick "Diablo-D3" McFarland || unknown@panax.com
