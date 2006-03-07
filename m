Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWCGPus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWCGPus (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 10:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWCGPus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 10:50:48 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:27707 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751297AbWCGPur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 10:50:47 -0500
Message-ID: <440DAB7A.2040301@cfl.rr.com>
Date: Tue, 07 Mar 2006 10:49:14 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: linux kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] udf: fix uid/gid options and add uid/gid=ignore and forget
 options
References: <4409EB37.5050308@cfl.rr.com> <84144f020603051122k33872fa7p1e7baebcc2b67cda@mail.gmail.com> <440B8C16.4050008@cfl.rr.com> <Pine.LNX.4.58.0603060924450.11070@sbz-30.cs.Helsinki.FI> <440CFCA6.5090100@cfl.rr.com> <Pine.LNX.4.58.0603070920360.15092@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0603070920360.15092@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2006 15:52:19.0024 (UTC) FILETIME=[1D462500:01C641FF]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14309.000
X-TM-AS-Result: No--13.890000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:
> Looks like you're using two spaces. Indentation is one tab and one tab is 
> exactly eight characters (see Documentation/CodingStyle).
> 

Wow!  8 spaces?  I always go with 4, 8 wastes way too much screen space. 
  Is there a handy incantation to get emacs to auto indent with a hard 
tab rather than 2 spaces like it does by default?

> Okay, fair enough. I see akpm has taken your patch. Please make sure the 
> mount options are documented. Thanks!
> 

I wrote up some docs for it last night.

> (Please note that we didn't fix the unconditional memset now, so there's 
>  dead code in udf_update_inode(). The check for TAG_IDENT_USE will always 
>  fail.)

Hrm... I'll take a look at that tonight and see what I come up with. 
Probably will resubmit the patch tomorrow.



