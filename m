Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288664AbSANS2W>; Mon, 14 Jan 2002 13:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288658AbSANS2N>; Mon, 14 Jan 2002 13:28:13 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:54662 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S288664AbSANS2E>; Mon, 14 Jan 2002 13:28:04 -0500
Message-ID: <3C43232C.6080101@redhat.com>
Date: Mon, 14 Jan 2002 13:27:56 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020103
X-Accept-Language: en-us
MIME-Version: 1.0
To: Thomas Gschwind <tom@infosys.tuwien.ac.at>
CC: Andris Pavenis <pavenis@latnet.lv>, linux-kernel@vger.kernel.org,
        mozgy@hinet.hr, linux@sigint.cs.purdue.edu
Subject: Re: i810_audio driver v0.20
In-Reply-To: <E16Okz2-0005JM-00@the-village.bc.nu> <200201110742.g0B7gDa16387@hal.astr.lu.lv> <3C3EA5D8.7050206@redhat.com> <200201111147.g0BBl5a01992@hal.astr.lu.lv> <3C3F0AA0.8030407@redhat.com> <20020113235454.A2949@infosys.tuwien.ac.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gschwind wrote:


> I also looked at the code.  What do think of replacing udelay(1); with
> if(offset == 0) udelay(1); in i810_get_dma_addr since the mentioned
> picb problem can only occur if picb == 0?


Sure, that should be fine.





-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

