Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVEYSZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVEYSZx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 14:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVEYSZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 14:25:52 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:26265 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S262370AbVEYSIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 14:08:01 -0400
Message-ID: <4294BEE5.7030100@nortel.com>
Date: Wed, 25 May 2005 12:07:33 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george@mvista.com
CC: bhavesh@avaya.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11 timeval_to_jiffies() wrong for ms resolution timers
References: <1116975555.2050.10.camel@cof110earth.dr.avaya.com> <4294B42D.2020008@mvista.com> <4294B7ED.2030307@nortel.com> <4294BBE8.3030004@mvista.com>
In-Reply-To: <4294BBE8.3030004@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:
> Chris Friesen wrote:

>> What about telling it to wake up a jiffy earlier, then checking 
>> whether the scheduling lag was enough to cause it to have waited the 
>> full specified time.  If not, put it to sleep for another jiffy.

> The user is, of course, free to do what ever they would like.  

I actually meant doing this in the kernel.

 > For a
> more complete solution you might be interested in HRT (High Res 
> Timers).  See my signature below.

Yep.  One more patch to apply and worry about versions and maintenance. 
  Not enough of a demand for us to be able to use it, at least at this 
point.

Chris

