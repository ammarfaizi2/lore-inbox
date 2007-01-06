Return-Path: <linux-kernel-owner+w=401wt.eu-S932135AbXAFUFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbXAFUFt (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 15:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbXAFUFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 15:05:49 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:36257 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932135AbXAFUFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 15:05:48 -0500
Date: Sat, 6 Jan 2007 21:03:54 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kernel-doc:  what is the purpose of "&struct"?
In-Reply-To: <20070106100019.98da5537.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.61.0701062102080.27682@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0701060941240.13398@localhost.localdomain>
 <20070106100019.98da5537.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 6 2007 10:00, Randy Dunlap wrote:
>On Sat, 6 Jan 2007 09:44:39 -0500 (EST) Robert P. J. Day wrote:
>
>>   according to the kernel-doc HOWTO, the following should be
>> "highlighted" in some way if found in the extractable documentation of
>> your source file:
>> 
>>   '&struct_name' - name of a structure (up to two words including 'struct')
>> 
>> but examples of that, at least in the HTML, are simply printed in
>> regular font prefixed with '&' -- i don't see that any "highlighting"
>> is being done.
>
>The struct name is highlighted in 'man' output mode.
>Not done in text or html output modes.

&something is quite ambiguous when it comes near C code. So far,
I have only used e.g. %NULL (%CONSTANT) since % is not an unary 
operator in C. On the other side, no marking up of any "struct".

	-`J'
-- 
