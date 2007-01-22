Return-Path: <linux-kernel-owner+w=401wt.eu-S1751756AbXAVMBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbXAVMBS (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 07:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbXAVMBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 07:01:18 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:46035 "HELO
	smtp102.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751756AbXAVMBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 07:01:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=tpiltJ3P0BcuFHeQe4wilBaY6xEQ7xYSsoU242m0qEH4tR3W0uN6MYC7D3aZr4dNYAbEoYCHdrqEsY4LCjfVxozULJniaR9s0Pv5xwJx2ANionm2IP0cdVxoxBU87eiw/lrBmg7YhodyslSbNsIIwyiljG/puLXBtfvQTMAy6bw=  ;
X-YMail-OSG: PTjboQ0VM1mhznIXJBPjDie2U6G9UpnsDCVwhXDBam8lHtkjMW9RJJvAo8uP9PMxlNUn4qD1gla4i1qhv8V6CEOdaNF0AUoFHRviTxFvgSy9NlCbY_oX_iMFQZt_W2s-
Message-ID: <45B4A76A.4070102@yahoo.com.au>
Date: Mon, 22 Jan 2007 23:00:42 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Nicholas Miell <nmiell@comcast.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linville@tuxdriver.com
Subject: Re: [PATCH] Introduce simple TRUE and FALSE boolean macros.
References: <Pine.LNX.4.64.0701210454590.2844@CPE00045a9c397f-CM001225dbafb6> <1169401892.2999.1.camel@entropy> <Pine.LNX.4.64.0701211430020.17235@CPE00045a9c397f-CM001225dbafb6> <45B495F9.4@yahoo.com.au> <Pine.LNX.4.64.0701220556580.22914@CPE00045a9c397f-CM001225dbafb6>
In-Reply-To: <Pine.LNX.4.64.0701220556580.22914@CPE00045a9c397f-CM001225dbafb6>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
> On Mon, 22 Jan 2007, Nick Piggin wrote:
> 
> 
>>Robert P. J. Day wrote:
>>
>>
>>>by adding (temporarily) the definitions of TRUE and FALSE to
>>>types.h, you should then (theoretically) be able to delete over
>>>100 instances of those same macros being *defined* throughout the
>>>source tree. you're not going to be deleting the hundreds and
>>>hundreds of *uses* of TRUE and FALSE (not yet, anyway) but, at the
>>>very least, by adding two lines to types.h, you can delete all
>>>those redundant *definitions* and make sure that nothing breaks.
>>>(it shouldn't, of course, but it's always nice to be sure.)
>>
>>Doesn't seem very worthwhile, and it legitimises this definition
>>we're trying to get rid of.
> 
> 
> hmmmmmmmm ... apparently, you totally missed my use of the important
> word "temporarily":

No, I didn't.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
