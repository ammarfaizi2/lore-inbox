Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbUBWAXU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 19:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbUBWAXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 19:23:20 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:8608 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S261289AbUBWAXS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 19:23:18 -0500
Message-ID: <403947F1.7060108@blue-labs.org>
Date: Sun, 22 Feb 2004 19:23:13 -0500
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040214
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: SONY SMO-F551, non-functional for a loong time :)
References: <E1Av3Ek-0000G2-00@sledge.mossbank.org.uk>
In-Reply-To: <E1Av3Ek-0000G2-00@sledge.mossbank.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.  I've since swapped that particular MO with another.  The hang on 
boot is back unless I set the speed down to 5M/s.  Still have problems 
reading/writing it so I'm trying a BusLogic adapter now.

Steve McIntyre wrote:

>David Ford writes:
>  
>
>>For the last couple of years, this MO drive (I have several) has been 
>>unusable.  It used to lock up the machine if I had a disc inside it when 
>>I booted, but that was late in 2.5, and now with 2.6.3, it no longer 
>>hangs the machine, however, it's still not usable.
>>
>>I'd love to get this bugger working, I used to use it a long long time 
>>ago in 2.4 kernels.  Any suggestions?
>>    
>>
>
>You've got hardware problems, either media or drive:
>
>  
>
>>sda: Unit Not Ready, sense:
>>Current : sense key Hardware Error
>>ASC=40 ASCQ=86
>>    
>>
>
>Key/code/qual 4/40/86 is (IIRC) Read Channel Calibration Failure,
>which means either the drive hardware is failing or (more likely) the
>disk loaded is buggered and the drive can't read it any more. Try
>another disk...
>
>  
>
