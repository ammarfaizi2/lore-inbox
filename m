Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbTF3VsR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 17:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265909AbTF3VsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 17:48:17 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:52172 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S265910AbTF3VsQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 17:48:16 -0400
Message-ID: <3F00B27D.9060008@rackable.com>
Date: Mon, 30 Jun 2003 14:58:21 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: ICH5-SATA file corruption under 2.4.21-ac1
References: <200306270956.h5R9uH911387@devserv.devel.redhat.com>
In-Reply-To: <200306270956.h5R9uH911387@devserv.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jun 2003 22:02:37.0462 (UTC) FILETIME=[5141FB60:01C33F53]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>  On an Intel winterpark motherboard I'm seeing file corruption when 
>>using the onboard SATA interface.  The test I'm running is ctcs's new 
>>kdiff test which just copies a kernel, diffs it, deletes the tree, and 
>>starts over.  (Which seems to find file system issues like this pretty 
>>quickly.) 
>>    
>>
>
>Random bit errors. This really doesn't look like an IDE layer problem
>to be honest. 
>  
>

  When I switch out the drive for a pata drive everything works.  Same 
system, and OS config.  This would seem to indicate an issue with the 
ide driver.

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


