Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131627AbQKJW0f>; Fri, 10 Nov 2000 17:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131980AbQKJW0Z>; Fri, 10 Nov 2000 17:26:25 -0500
Received: from natted.Sendmail.COM ([63.211.143.38]:6226 "EHLO
	wiz.Sendmail.COM") by vger.kernel.org with ESMTP id <S131627AbQKJW0Q>;
	Fri, 10 Nov 2000 17:26:16 -0500
Date: Fri, 10 Nov 2000 14:25:47 -0800
From: Claus Assmann <sendmail+ca@sendmail.org>
To: David Lang <david.lang@digitalinsight.com>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, sendmail-bugs@sendmail.org,
        linux-kernel@vger.kernel.org
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
Message-ID: <20001110142547.F16213@sendmail.com>
Reply-To: sendmail-bugs@sendmail.org
In-Reply-To: <3A0C6E01.EFA10590@timpanogas.org> <Pine.LNX.4.21.0011101450060.11307-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0011101450060.11307-100000@dlang.diginsite.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000, David Lang wrote:
> how many CPUs in these high loadave boxes? unless you have a very
> impressive machine (8+SMP) the defaults should be plenty high.
> 
> also I thought the QueueLA default was 8 and the RefuseLA was 12 or have
> they been bumped up since I last examined them (8.8/8.9 timeframes)

Those are the defaults. Jeff quoted the values from the .cf file
I edited on his machine to get the e-mails through.

> > We got to the bottom of the sendmail problem.  The line:
> > 
> >  -O QueueLA=20 
> > 
> > and
> > 
> >  -O RefuseLA=18

Why does Linux report a LA of 10 if there are only two processes
running?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
