Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288256AbSAHTVb>; Tue, 8 Jan 2002 14:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288255AbSAHTVW>; Tue, 8 Jan 2002 14:21:22 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:10784 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S288256AbSAHTVK>; Tue, 8 Jan 2002 14:21:10 -0500
Message-ID: <3C3B46A4.3020408@redhat.com>
Date: Tue, 08 Jan 2002 14:21:08 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020103
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mario Mikocevic <mozgy@hinet.hr>
CC: Thomas Gschwind <tom@infosys.tuwien.ac.at>,
        Nathan Bryant <nbryant@allegientsystems.com>,
        linux-kernel@vger.kernel.org
Subject: Re: i810_audio
In-Reply-To: <20020105031329.B6158@infosys.tuwien.ac.at> <3C3A2B5D.8070707@allegientsystems.com> <3C3A301A.2050501@redhat.com> <3C3AA6F9.5090407@redhat.com> <3C3AA9AD.6070203@redhat.com> <3C3AB5AB.2080102@redhat.com> <20020108161137.A6747@danielle.hinet.hr>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mario Mikocevic wrote:

> Hi,
> 
> 
>>OK, various clean ups made, and enough of the SiS code included that I think 
>>it should work, plus one change to the i810 interrupt handler that will 
>>(hopefully) render the other change you made to get_dma_addr and drain_dac 
>>unnecessary.  If people could please download and test the new 0.14 version 
>>of the driver on my site, I would appreciate it.
>>
>>http://people.redhat.com/dledford/i810_audio.c.gz
>>
> 
> Hmmm, maybe way too much cleanups !? :)
> 
> -->
> 
> i810_audio.c: In function `i810_get_dma_addr':
> i810_audio.c:658: warning: unused variable `c'
> i810_audio.c: In function `__stop_dac':
> i810_audio.c:747: `PI_OR' undeclared (first use in this function)
> i810_audio.c:747: (Each undeclared identifier is reported only once
> i810_audio.c:747: for each function it appears in.)
> make[2]: *** [i810_audio.o] Error 1
> make[1]: *** [_modsubdir_sound] Error 2
> make: *** [_mod_drivers] Error 2
> 


Sorry.  Version that compiles is now on my web site.


> ps
> 	just got a note from a friend that .13 has tendency to lockup with
> 	heavy network traffic in the same time, no oops, nothing, ..
> 
> 



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

