Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289995AbSAKPy2>; Fri, 11 Jan 2002 10:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289996AbSAKPyS>; Fri, 11 Jan 2002 10:54:18 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:13341 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289995AbSAKPyN>; Fri, 11 Jan 2002 10:54:13 -0500
Message-ID: <3C3F0AA0.8030407@redhat.com>
Date: Fri, 11 Jan 2002 10:54:08 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020103
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andris Pavenis <pavenis@latnet.lv>
CC: tom@infosys.tuwien.ac.at, linux-kernel@vger.kernel.org, mozgy@hinet.hr,
        linux@sigint.cs.purdue.edu
Subject: Re: i810_audio driver v0.19 still freezes machine
In-Reply-To: <E16Okz2-0005JM-00@the-village.bc.nu> <200201110742.g0B7gDa16387@hal.astr.lu.lv> <3C3EA5D8.7050206@redhat.com> <200201111147.g0BBl5a01992@hal.astr.lu.lv>
Content-Type: text/plain; charset=ISO-8859-13; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andris Pavenis wrote:


> Tried. I haven't been able to freeze box after some not very long torturing 
> with artsd, but there is another new trouble:
> 
> For test I'm letting artsd to play some WAV file and after that give some 
> time for it to close /dev/dsp. After some times there is no more sound and 
> I'm getting a message that /dev/dsp is busy when trying to restart artsd. 
> Anyway I can reload i810_audio driver and restart artsd to get sound working 
> again. 'fuser /dev/dsp' also doesn't show that it is opened


Actually, as a couple people have pointed out to me, the version on my site 
was somehow a .19 version.  I've placed the real .20 on my site as of a few 
  minutes ago, so please try with it (and the real .20 should solve the 
problem you are related Andris in that it won't allow the driver to accept 
signals during close, which is why /dev/dsp would quit working for you).




-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

