Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261481AbSJCXhU>; Thu, 3 Oct 2002 19:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261484AbSJCXhU>; Thu, 3 Oct 2002 19:37:20 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:4076 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S261481AbSJCXhT>; Thu, 3 Oct 2002 19:37:19 -0400
Message-ID: <3D9CD647.7000806@snapgear.com>
Date: Fri, 04 Oct 2002 09:44:07 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.40-ac1
References: <Pine.LNX.4.44L.0210031614030.1909-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

Rik van Riel wrote:
> On Thu, 3 Oct 2002, Christoph Hellwig wrote:
> 
>>On Thu, Oct 03, 2002 at 10:20:03AM -0400, Alan Cox wrote:
> 
> 
>>>The two are so different I think that keeping it seperate is actually the
>>>right idea personally.
>>
>>Did you actually take a look?  Many files are basically the same and other
>>are just totally stubbed out in nommu.
> 
> 
> So how about having one mm/ directory with:
> 
> 1) the common stuff
> 2) the MMU stuff
> 3) the NOMMU stuff
> 
> ... and some magic in Makefile to select which .c files to
> compile ?
> 
> That should keep code duplication to a minimum.

Easy done. Would it bother anyone having a few files
named XYZ-nommu.c in there?

Although the sticking point may be the common files that
still contain a lot of ifdefs.

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

