Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbVKYEHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbVKYEHN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 23:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbVKYEHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 23:07:13 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:41823 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751407AbVKYEHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 23:07:11 -0500
Date: Thu, 24 Nov 2005 22:06:36 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [RFC] Small PCI core patch
In-reply-to: <5bHtG-228-23@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43868DCC.9090101@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5bsXq-5uy-3@gated-at.bofh.it> <5bsXq-5uy-1@gated-at.bofh.it>
 <5btqF-66n-41@gated-at.bofh.it> <5bzmg-66b-1@gated-at.bofh.it>
 <5bHtG-228-23@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> One sticking point is validation:  ensuring userspace cannot cause
> invalid GPU microcode to be generated.  [I can just hear Al Viro
> swearing, just thinking about creating secure compilers...]

I suspect the amount of data going through is large enough that this 
wouldn't really be practical. I think you'd have to deal with the code 
generating GPU instructions having to be trusted and have the device 
interface require root privileges..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

