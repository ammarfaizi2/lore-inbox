Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289585AbSAJSRJ>; Thu, 10 Jan 2002 13:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289581AbSAJSQ7>; Thu, 10 Jan 2002 13:16:59 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:984 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289587AbSAJSQr>; Thu, 10 Jan 2002 13:16:47 -0500
Message-ID: <3C3DDA8B.4090004@redhat.com>
Date: Thu, 10 Jan 2002 13:16:43 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020103
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andris Pavenis <pavenis@latnet.lv>
CC: tom@infosys.tuwien.ac.at, linux-kernel@vger.kernel.org
Subject: Re: i810_audio driver v0.19 still freezes machine
In-Reply-To: <200201101058.g0AAwJH00606@hal.astr.lu.lv>
Content-Type: text/plain; charset=ISO-8859-13; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andris Pavenis wrote:

> I found that i810_audio driver v0.19 from 
> 	http://people.redhat.com/dledford/i810_audio.c.gz
> still freezes machine after /dev/dsp is being closed 
> (printk at end of i810_release()). It doesn't happen always though.


I'm unable to duplicate this (the current 0.19 driver doesn't hang at all on 
me now under any of my tests).  Try to find a way to duplicate it (either by 
playing a specific wav file using the play command, or by doing something in 
particular to make artsd do it, or something else).  If you can find a way 
to duplicate it, then I can see about getting a proper fix for it.


> I did tests under KDE. artsd is setup to close /dev/dsp after being idle 
> for 5 seconds. System rather often (but not always) freezes
> after that.
> 
> Earlier v0.14 from
> 	http://www.infosys.tuwien.ac.at/Staff/tom/SiS7012/i810_audio-020105.c
> doen't cause similar problems for me
> 
> Andris
> 
> 



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

