Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVHCEV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVHCEV0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 00:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVHCEV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 00:21:26 -0400
Received: from dvhart.com ([64.146.134.43]:22459 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262015AbVHCEVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 00:21:25 -0400
Date: Tue, 02 Aug 2005 21:21:29 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
Message-ID: <36680000.1123042889@[10.10.2.4]>
In-Reply-To: <30040000.1123031853@[10.10.2.4]>
References: <20050728025840.0596b9cb.akpm@osdl.org><159960000.1122616883@[10.10.2.4]> <20050728231029.0c0026bc.akpm@osdl.org> <30040000.1123031853@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--"Martin J. Bligh" <mbligh@mbligh.org> wrote (on Tuesday, August 02, 2005 18:17:33 -0700):
> --Andrew Morton <akpm@osdl.org> wrote (on Thursday, July 28, 2005 23:10:29 -0700):
> 
>> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
>>> 
>>> NUMA-Q boxes are still crashing on boot with -mm BTW. Is the thing we 
>>> identified earlier with the sched patches ...
>>> 
>>> http://test.kernel.org/9398/debug/console.log
>> 
>> Oh, thanks.  That's about 8,349 bugs ago and I'd forgotten.
>> 
>>> Works with mainline still (including -rc4) ... hopefully those patches 
>>> aren't on their way upstream anytime soon ;-)
>> 
>> Well can you identify the offending patch(es)?  If so, I'll exterminate them.
> 
> scheduler-cache-hot-autodetect.patch, I think.
> 
> will double-check.

Yup, backing out that one patch definitely fixes it. There was an earlier
thread with Ingo about doing some possible debug on it, but to be honest,
I haven't had time to play much beyond the initial ideas we tried.

M.
