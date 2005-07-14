Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262910AbVGNFdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbVGNFdH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 01:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbVGNFdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 01:33:07 -0400
Received: from BTNL-TN-DSL-static-006.0.144.59.touchtelindia.net ([59.144.0.6]:15489
	"EHLO mail.prodmail.net") by vger.kernel.org with ESMTP
	id S262910AbVGNFdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 01:33:06 -0400
Message-ID: <42D5F8B7.2070508@prodmail.net>
Date: Thu, 14 Jul 2005 11:01:35 +0530
From: RVK <rvk@prodmail.net>
Reply-To: rvk@prodmail.net
Organization: GSEC1
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benedikt Spranger <b.spranger@linutronix.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Thread_Id
References: <20050723150209.GA15055@krispykreme>	 <42CA79DE.9060701@prodmail.net> <1120740201.4988.53.camel@atlas.tec.linutronix.de>
In-Reply-To: <1120740201.4988.53.camel@atlas.tec.linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are right Ben....gettid() will do for me. Previously for 2.4.x 
(2.4.18)thread libraries I normally was using pthread_self().

Raghu

Benedikt Spranger wrote:

>Hi,
>  
>
>>Can anyone suggest me how to get the threadId using 2.6.x kernels.
>>pthread_self() does not work and returns some -ve integer.
>>    
>>
>
>Let me guess: You are looking for get_tid() :-)
>
>Bene
>.
>
>  
>

