Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVAOAqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVAOAqg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVAOAqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:46:36 -0500
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:22415 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262063AbVAOAqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:46:30 -0500
Message-ID: <41E868E2.60402@sbcglobal.net>
Date: Fri, 14 Jan 2005 16:50:42 -0800
From: Steve <s.egbert@sbcglobal.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050109)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: disabling VESAFB no longer locks up VT (was Re: 2.4.10-r1 MTRR
 bug)
References: <41E595E9.8040805@sbcglobal.net> <20050112230553.683a813b.akpm@osdl.org> <41E84729.1090209@gentoo.org>
In-Reply-To: <41E84729.1090209@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:

> Hi Andrew,
>
> Andrew Morton wrote:
>
>> Steve <s.egbert@sbcglobal.net> wrote:
>>
>>> For the Athlon 2100, I get the following outputs and then the VGA 
>>> console is frozen from further output (but it doesn't prevent the 
>>> full bootup into X windows session of which I am able to resume 
>>> normal Linux/X session, but not able to regain any virtual console 
>>> session.)
>>
>>
>>
>> hm.  Not sure what could have caused that.
>
>
> This may be a problem in Gentoo's kernels, we offer an experimental 
> version of vesafb... 

Disabling the VESAFB resulted in regaining control of the VTs (virtual 
terminals).
