Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbREUQig>; Mon, 21 May 2001 12:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261489AbREUQiQ>; Mon, 21 May 2001 12:38:16 -0400
Received: from viper.haque.net ([66.88.179.82]:53705 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S261418AbREUQiG>;
	Mon, 21 May 2001 12:38:06 -0400
Message-ID: <3B094401.502463F7@haque.net>
Date: Mon, 21 May 2001 12:36:17 -0400
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Harald Dunkel <harri@synopsys.COM>
CC: linux-kernel@vger.kernel.org
Subject: Re: Giant disk on 2.2.17: Any concerns?
In-Reply-To: <3B094183.24148B9D@Synopsys.COM>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel wrote:
> 
> Hi folks,
> 
> For running some kind of database application (ClearCase 4.1) I would
> like to attach an external RAID array with 6*30GByte to a RedHat 6.2
> machine, using kernel 2.2.17. I don't expect huge files (maximum file
> size should be about 250MByte), but a lot of middle size files and
> millions of tiny files.
> 
> Will this work?
> 
> Do you expect any problems with the partition table?

I've used a 250GB and 400GB RAID array with 2.2.x kernels w/o any
problems. We have several thousands of ~1 MB
and >100 MB files.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
