Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbSLUAnx>; Fri, 20 Dec 2002 19:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSLUAnx>; Fri, 20 Dec 2002 19:43:53 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:57101
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S261799AbSLUAnu>; Fri, 20 Dec 2002 19:43:50 -0500
Message-ID: <3E03BB0D.5070605@rackable.com>
Date: Fri, 20 Dec 2002 16:51:25 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>, marcelo@conectiva.com.br
CC: Janet Morgan <janetmor@us.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] aic7xxx bouncing over 4G
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com> <176730000.1040430221@aslan.btc.adaptec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Dec 2002 00:51:45.0819 (UTC) FILETIME=[22D65EB0:01C2A88B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin T. Gibbs wrote:

>>I have an Adaptec AIC-7897 Ultra2 SCSI adapter on a system with 8G
>>of physical memory.  The adapter is using bounce buffers when DMA'ing
>>to memory >4G because of a bug in the aic7xxx driver. 
>>    
>>
>
>This has been fixed in both the aic7xxx and aic79xx drivers for some
>time.  The problem is that these later revisions have not been integrated
>into the mainline trees.
>
>  
>
  Marcelo, what is required get the aic79xx driver, and the aic7xxx 
updates into 2.4.21?  A number of linux distros are already using it. 
 It would really help people using board with the U320.  

    I've been using both drivers for some time with no issues.  Or maybe 
you'd prefer Alan put it in his tree 1st?

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>



