Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTE2Whi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 18:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbTE2Whi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 18:37:38 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:20711 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263025AbTE2Whh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 18:37:37 -0400
Message-ID: <3ED68E3E.1060403@austin.ibm.com>
Date: Thu, 29 May 2003 17:48:30 -0500
From: Mark Peloquin <peloquin@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Nightly regression runs against current bk tree
References: <3ED66C83.8070608@austin.ibm.com.suse.lists.linux.kernel> <p73smqx791m.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andi Kleen wrote:

>Mark Peloquin <peloquin@austin.ibm.com> writes:
>
>  
>
>>We have dedicated a machine and thrown together some scripts that will grab
>>and build the latest kernel files, execute the regression suite,
>>collecting (hopefully)
>>enough system state information to allow meaningful analysis of any peculiar
>>results encountered.
>>    
>>
>
>How about doing a LTP run too with some difference file for new FAILs/BROKs ?
>That's not strictly a benchmark, but would help catching regressions
>quickly.
>

I'm under the impression that LTP and other test efforts seemed to focus 
more on functional evaluation, which is fine.  We are trying to focus 
purely on the performance differences seen from day to day.

>
>I notice your benchmark mix is very IO heavy, it would be nice to test other
>aspects of the system too. Perhaps lmbench and reaim compute workload?
>

Your correct. We're just getting started with this effort and we used 
this mix to get things going. Once ppl are happy with the presentation 
of data, we planned to add more tests to provide a more balanced mix. 
But since you asked, we have added lmbench to our -bk3 regression run. :)

Mark

