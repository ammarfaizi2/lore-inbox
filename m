Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289659AbSAJT1J>; Thu, 10 Jan 2002 14:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289639AbSAJT1B>; Thu, 10 Jan 2002 14:27:01 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:8 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289626AbSAJT0v>; Thu, 10 Jan 2002 14:26:51 -0500
Message-ID: <3C3DEAFA.4070102@redhat.com>
Date: Thu, 10 Jan 2002 14:26:50 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020103
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andris Pavenis <pavenis@latnet.lv>, tom@infosys.tuwien.ac.at,
        linux-kernel@vger.kernel.org
Subject: Re: i810_audio driver v0.19 still freezes machine
In-Reply-To: <E16Okz2-0005JM-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>I'm unable to duplicate this (the current 0.19 driver doesn't hang at all on 
>>me now under any of my tests).  Try to find a way to duplicate it (either by 
>>playing a specific wav file using the play command, or by doing something in 
>>particular to make artsd do it, or something else).  If you can find a way 
>>to duplicate it, then I can see about getting a proper fix for it.
>>
> 
> Make sure you test with both apic and non apic Doug. The previous hangs I
> fixed up were specific to APIC mode because the APIC means the irq arrival
> is later and more asynchronous
> 
> 

I can't.  APIC makes my test machine (my only i810 machine) hang on boot :-(

-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

