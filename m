Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWCNNbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWCNNbK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 08:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWCNNbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 08:31:09 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:62913 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932445AbWCNNbJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 08:31:09 -0500
Message-ID: <4416C590.5040509@aitel.hist.no>
Date: Tue, 14 Mar 2006 14:30:56 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davids@webmaster.com
CC: mr.fred.smoothie@gmail.com,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [future of drivers?] a proposal for binary drivers.
References: <MDEHLPKNGKAHNMBLJOLKOEAJKLAB.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKOEAJKLAB.davids@webmaster.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:

>  
>
>>In Static Controls, the issue was a 55 byte program to calculate the
>>level of toner in a cartridge. The court ruled that the program design
>>of the TLP was so constrained by external factors (the efficient
>>execution of a small number of calculations) that any other
>>implementation would have been impractical.
>>    
>>
>
>	Exactly. And this is precisely what is happening here. The kernel headers
>are small in comparison to the kernel. And external factors are such that
>there is no other way to create kernel modules other than by using the
>kernel headers.
>  
>
Smaller than the kernel, but still big.  These are not 55 bytes.
And the kernel headers are not unique either.  You can make
many changes and still be able to use them for a driver.

>>Linux is a completely different matter, directly analogous to Apple's
>>OS in the court's analysis. There are no such external factors
>>dictating the form of the kernel's facilities for integrating new
>>functionality.
>>    
>>
>
>	You are saying there are practical ways to develop kernel modules other
>than using the kernel headers?
>  
>
Many of these interfaces are published.  Buy a linux device driver
book and write your own headers - possibly with different names
for the types involved.  Structs or just a bunch of variables in a
certain order?  Your call again.  You won't get everything this way,
but you don't need everything to write one driver.

Then there is reverse engineering.  More work, but certainly
feasible seeing how many linux drivers were written this way.

Helge Hafting
