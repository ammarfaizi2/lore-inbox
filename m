Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271371AbRHXNRl>; Fri, 24 Aug 2001 09:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271370AbRHXNRb>; Fri, 24 Aug 2001 09:17:31 -0400
Received: from redbull.speedroad.net ([195.139.232.25]:60164 "HELO
	redbull.speedroad.net") by vger.kernel.org with SMTP
	id <S271006AbRHXNRY>; Fri, 24 Aug 2001 09:17:24 -0400
Date: Fri, 24 Aug 2001 15:15:11 +0200
From: Arnvid Karstad <arnvid@karstad.org>
To: paalchr@linuxnation.net, linux-kernel@vger.kernel.org
Subject: Re: Determining maximum partition size on a hard disk
In-Reply-To: <0108241047280B.08728@vixen>
In-Reply-To: <0108241047280B.08728@vixen>
Message-Id: <20010824151453.7806.ARNVID@karstad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 24 Aug 2001 10:47:28 +0200
Paal Chr Birkeland <paalchr@linuxnation.net> wrote:

> >
> > First I found that the maximum size of the drive Linux reports is not
> > the maximum size I get when I calculate it from the drives geometry.
> > Secondly, the total drive space reported by linux is not the amount
> > available for the maximum partition.
> >
> 
> tune2fs -m 2 /dev/hd-whatever-hdd
> 
> For some reason linux still "eats" 5% of the hdd. This for still beeing able 
> to run smooth if hdd is maxed out, or something like that.
> I dont know if the tune2fs is a slackware feature only, but i doubt it. Then
> again I havent really "tried" any other distro.
> Inputs ?


You can you choose this when you make the filesystem..

By using the -m option to mke2fs you can set the
reserved-block-percentage ... and can eay overide this then to 0 or 3
percent...

       -m reserved-blocks-percentage
              Specify the percentage of reserved blocks for the super-user.  This value defaults to 5%.

afaik, the 5% option is a mke2fs default for all distributions.


Best regards,

Arnvid Karstad
Speedroad Networks
