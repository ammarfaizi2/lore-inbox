Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288672AbSADPjr>; Fri, 4 Jan 2002 10:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288676AbSADPjh>; Fri, 4 Jan 2002 10:39:37 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:37125 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S288672AbSADPjb>; Fri, 4 Jan 2002 10:39:31 -0500
Message-ID: <3C35CCB1.8040900@redhat.com>
Date: Fri, 04 Jan 2002 10:39:29 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020103
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ben Clifford <benc@hawaga.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: i810_audio]
In-Reply-To: <Pine.LNX.4.33.0201032122510.505-100000@barbarella.hawaga.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Clifford wrote:

> I took have problems recording. I'm using the i810 driver
> in 2.4.16
> 
> I can do:
> 
> cat < /dev/sound/dsp > /dev/sound/dsp
> 
> and get a few seconds delayed echo of what is going on, as I would expect.
> 
> However, if I try to use anything more complicated, it locks up my system
> - no keyboard, no network, needs to be hard booted.
> 
> The programs I have tried are "rec" which comes with sox-12.17.1 and a
> downloaded utility called voice chat.
> 
> What happens is: the recording happens, but when the program ends, either
> by itself or by being killed, the system locks up.
> 
> So maybe this is something to do with restoring settings at the end of the
> recording?
> 
> Playback happens with no problem.
> 
> Below is the lspci output for the sound system, if it is of any use.
> 
> If there is any more info anyone wants, please ask.


Your particular report sounds like the recording bugs that have already been 
fixed by my 0.13 version of the driver.  Please download that and see if 
recording works better for you.  It can be found at 
http://people.redhat.com/dledford/i810_audio.c.gz

 



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

