Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271347AbRHOS3E>; Wed, 15 Aug 2001 14:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271348AbRHOS2z>; Wed, 15 Aug 2001 14:28:55 -0400
Received: from [194.102.102.3] ([194.102.102.3]:17412 "EHLO ns1.Aniela.EU.ORG")
	by vger.kernel.org with ESMTP id <S271347AbRHOS2g>;
	Wed, 15 Aug 2001 14:28:36 -0400
Date: Wed, 15 Aug 2001 21:28:30 +0300 (EEST)
From: <lk@Aniela.EU.ORG>
To: God <atm@sdk.ca>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?] :: "Value too large for defined data type"
In-Reply-To: <Pine.LNX.4.21.0108150418230.8270-100000@scotch.homeip.net>
Message-ID: <Pine.LNX.4.33.0108152127520.4092-100000@ns1.Aniela.EU.ORG>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> # echo *
> box1.071401.dump test
> #
>
> I tried to remove the file using rm, but I get the same error as ls:


do this:

 # > test
 # rm test

and it will delete the file
>
> # rm test
> rm: cannot remove `test': Value too large for defined data type
> #
>
> The file is taking up ~4G of space (which is reflected correctly with df,
> du will not read the file).
>
> It was a stupid thing to do, but could there be a better way for the OS to
> handle this and is there any way I can remove the file?  It's on  a 60
> Gig drive, so formatting would not be an option right about now ...
>
> The box in question (box2), is running Slack with a 2.4.3 kernel:
>
> # uname -a
> Linux box2 2.4.3 #7 SMP Sun Apr 29 13:42:05 EDT 2001 i686 unknown
> #
>
>
> Any thoughts?
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

