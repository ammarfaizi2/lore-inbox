Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269290AbTGOSjv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269268AbTGOSju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:39:50 -0400
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:14763
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id S269324AbTGOSiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:38:08 -0400
Message-ID: <3F144D88.8000401@tupshin.com>
Date: Tue, 15 Jul 2003 11:52:56 -0700
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030618
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: "Ranga Reddy M - CTD ,Chennai." <rangareddym@ctd.hcltech.com>,
       linux-kernel@vger.kernel.org
Subject: Re: setting year to 2094 casuing Error.
References: <EF836A380096D511AD9000B0D021B5270153C968@narmada.techmas.hcltech.com>            <3F13A0B7.6050103@tupshin.com> <200307151417.h6FEHkMQ010873@turing-police.cc.vt.edu>
In-Reply-To: <200307151417.h6FEHkMQ010873@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>On Mon, 14 Jul 2003 23:35:35 PDT, Tupshin Harper said:
>  
>
>>Ranga Reddy M - CTD ,Chennai. wrote:
>>    
>>
>>>I have set the system time from BIOS to 17/03/2094.After setting this
>>>,booted with linux O.S. 
>>>
>>>Now its showing system date as year=1994.I did not get how this happend.
>>>      
>>>
>
>  
>
>>http://www.howstuffworks.com/question75.htm
>>    
>>
>
>Yes, but if it was a 2038 problem, you'd expect a date in 2094 to roll over to 2026 (as
>2094 is 56 years past 2038, and 2026 is 56 past 1970).
>
>I suspect he has a crippled clock chip that only keeps 2 digits of year.
>  
>
Agreed...I didn't do the math to verify that was his only problem, but 
he seemed unaware that there are *any* known problems with dates in the 
future, and the URL i sent was merely designed to point out that such 
dates are unsupported for now.

-Tupshin

