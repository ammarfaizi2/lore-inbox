Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317115AbSF1LZh>; Fri, 28 Jun 2002 07:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317140AbSF1LZg>; Fri, 28 Jun 2002 07:25:36 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:48681 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S317115AbSF1LZg>; Fri, 28 Jun 2002 07:25:36 -0400
Date: Fri, 28 Jun 2002 07:27:57 -0400
From: Doug Ledford <dledford@redhat.com>
To: Uwe Ziegler <aquahasi@compuserve.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem: SCSI (initio 9100u) and kernel 2.5.24
Message-ID: <20020628072757.B23266@redhat.com>
Mail-Followup-To: Uwe Ziegler <aquahasi@compuserve.de>,
	linux-kernel@vger.kernel.org
References: <001501c21e96$2096b2f0$1601a8c0@surfstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <001501c21e96$2096b2f0$1601a8c0@surfstation>; from aquahasi@compuserve.de on Fri, Jun 28, 2002 at 01:22:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2002 at 01:22:44PM +0200, Uwe Ziegler wrote:
> hello,
> i tried to compile the new 2.5.24 kernel with modular scsi-support for
> initio 9100u on my suse 7.3 system
> 
> ......
> # ini9100u.c : 111 : # error Please convert me to
> Documentation/DMA-mapping.txt
> .......
> 
> This problem is too difficult for me, but i´m intrested in the solution,
> when this message becomes a tread.

I'm trying to finalise my changes to the initio a100 driver.  This one is 
next on my list.  I'll probably have a first cut of a patch for this 
within a few days, maybe sometime early next week.

I haven't spent a lot of time looking at it yet, but if it's as close to 
the a100 driver as I think it is, I may end up just merging both of the 
drivers into one "drives all initio cards" driver.  At first glance, these 
two drivers appear to damn near be duplicates of each other...

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
