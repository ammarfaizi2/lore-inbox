Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281420AbRLADBq>; Fri, 30 Nov 2001 22:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281416AbRLADBh>; Fri, 30 Nov 2001 22:01:37 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:60946 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S283903AbRLADBY>; Fri, 30 Nov 2001 22:01:24 -0500
Message-ID: <3C084803.9090507@redhat.com>
Date: Fri, 30 Nov 2001 22:01:23 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011129
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Bryant <nbryant@optonline.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: i810 audio, problems with both GPL and 4Front driver
In-Reply-To: <3C083424.7090309@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Bryant wrote:

> 
> FYI,
> 
> On my machine, the changes in 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=100651447318071&w=2 or 
> 2.4.17-pre1 don't fix the KDE problems, as alleged. artsd still exits 
> after consuming too much CPU. I've tried reducing fragment size to 512 
> with no effect.
> 
> If it makes any difference to the driver, the kernel is running with 
> APIC's and ACPI enabled on a uniprocessor build (Wow, acronym soup. ;)
> 
> for what it's worth, 4Front's binary driver (3.9.5, 3.9.6) has problems 
> too on this machine. KDE works but there are audio pops/speedups/stops. 
> (xmms, in particular, likes to stop for a while, then resume, sometimes 
> after a speedup.)


Just because I've been hearing about this stuff forever and the powers 
that be didn't take my i810_audio.c driver version 0.05 for some reason, 
I've place my 0.05 i810_audio.c file on my web site for anyone 
interested in testing it to see how it does.

http://people.redhat.com/dledford/i810_audio.c.gz





-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

