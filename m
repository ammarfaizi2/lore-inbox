Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbULIXr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbULIXr1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 18:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbULIXr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 18:47:27 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:51358 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261162AbULIXrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 18:47:22 -0500
Message-ID: <41B8E6A5.3090103@devicelogics.com>
Date: Thu, 09 Dec 2004 16:58:29 -0700
From: "Jeff V. Merkey" <jmerkey@devicelogics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: kernel-stuff@comcast.net, Imanpreet Singh Arora <imanpreet@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question from Russells Spinlocks
References: <120920042115.25628.41B8C082000394E30000641C220076219400009A9B9CD3040A029D0A05@comcast.net> <Pine.LNX.4.60.0412092326260.2294@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.60.0412092326260.2294@hermes-1.csi.cam.ac.uk>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:

>
>
>Your last sentence is incorrect.  Spinlocks on 1 CPU machines still need 
>to disable preemption (assuming preemption is compiled in obviously, if 
>not then indeed you are right).  Otherwise preemption could take place in 
>the middle of a data manipulation and you would still have the same race 
>as you described with two cpus working concurrently.  Except that with 
>preemption it is only logical concurrence not actual physical concurrence.
>
>Best regards,
>
>	Anton
>
>  
>

Anton is correct in his analysis.

Jeff
