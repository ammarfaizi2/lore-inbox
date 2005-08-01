Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVHASLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVHASLY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVHASJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:09:53 -0400
Received: from rutherford.zen.co.uk ([212.23.3.142]:36567 "EHLO
	rutherford.zen.co.uk") by vger.kernel.org with ESMTP
	id S261398AbVHASJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:09:51 -0400
Message-ID: <42EE650A.60109@dresco.co.uk>
Date: Mon, 01 Aug 2005 19:08:10 +0100
From: Jon Escombe <lists@dresco.co.uk>
Reply-To: lists@dresco.co.uk
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: abonilla@linuxwireless.org
CC: linux-kernel@vger.kernel.org,
       hdaps devel <hdaps-devel@lists.sourceforge.net>,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>, Dave Hansen <dave@sr71.net>
Subject: Re: [Hdaps-devel] Re: IBM HDAPS, I need a tip.
References: <1122861215.11148.26.camel@localhost.localdomain> <1122872189.5299.1.camel@localhost.localdomain>
In-Reply-To: <1122872189.5299.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Hops: 1
X-Originating-Rutherford-IP: [82.68.23.174]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>Thanks to development of the driver from some nice guys, we are able to
>>get data from the accelerometer. There is one problem. How do we
>>calibrate the values that are outputed from the userspace? All PC's get
>>a different value, and we can't really find the best solution. What is
>>the scientific and smartest way to do this?
>>    
>>

I'm not convinced we need to get so hung up on the calibration. Sure, 
each laptop has somewhat different resting values - but surely what 
we're looking for is any rate of change in either the X or Y values 
thats over a predefined 'safe' threshold? (I would imagine that we're 
only going to find that safe threshold from some imaginative testing 
once we've got the head parking sorted....)

Just my 2p worth,
Jon.


______________________________________________________________
Email via Mailtraq4Free from Enstar (www.mailtraqdirect.co.uk)
