Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137129AbRA1OIh>; Sun, 28 Jan 2001 09:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137109AbRA1OI1>; Sun, 28 Jan 2001 09:08:27 -0500
Received: from mail08.voicenet.com ([207.103.0.34]:31941 "HELO mail08")
	by vger.kernel.org with SMTP id <S137070AbRA1OHp>;
	Sun, 28 Jan 2001 09:07:45 -0500
Message-ID: <3A7427AB.88D08577@voicenet.com>
Date: Sun, 28 Jan 2001 09:07:39 -0500
From: safemode <safemode@voicenet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linda Walsh <law@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4 Cpu usuage (display oddities more than anything)
In-Reply-To: <3A7381C2.C512B76C@sgi.com> <3A738289.4F7CBBFA@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linda Walsh wrote:

> Some oddities w/kapmd(2.4.0)...  If I sit in X and do nothing other than run top or
> "vmstat 5", I get down to as low as 60% idle and 40% in system -- with kapmd getting
> 'charged' for the 40%.
>
> Then I go and run 'freeamp' and the CPU usage goes to 100% idle, presumably because
> kapmd never gets called because it's never in the idle loop for longer than 333ms.
>
> It's just weird and unnatural.
>
> Also forgive my ignorance but is it really possible playing VBR MP3's takes 0 measurable
> CPU?  I've run the program for hours and a ps of 'freeamp' show either no measured cpu
> time or maybe 1 second...the kernel runs at at 100% idle for most of the time.
> I thought mp3 decompression was a cpu intensive operation....weird...
>
> I guess I'm thinking -- maybe time in kapmd should be counted as 'idle'?
>

  freeamp is just that good.  I've seen 0% cpu usage with it on 2.4 and 2.2.   if you
notice closely, it does use  a percentage of cpu but it's so small that over the course of
time that the cpu usage of each process is averaged, it is closer to 0 than 1.  It is hands
down the best mp3 player i've seen out.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
