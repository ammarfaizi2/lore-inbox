Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVCKUtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVCKUtZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 15:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVCKUpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 15:45:33 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:14479 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261604AbVCKUnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 15:43:11 -0500
Message-ID: <423202D2.8000207@nortel.com>
Date: Fri, 11 Mar 2005 14:42:58 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: "Justin M. Forbes" <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.Stable and EXTRAVERSION
References: <20050309185331.GB19306@linuxtx.org> <4231F7C8.7070806@tmr.com>
In-Reply-To: <4231F7C8.7070806@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> Justin M. Forbes wrote:
> 
>> With the new stable series kernels, the .x versioning is being added to
>> EXTRAVERSION.  This has traditionally been a space for local 
>> modification.
>> I know several distributions are using EXTRAVERSION for build numbers,
>> platform and assorted other information to differentiate their kernel
>> releases.
>> I would propose that the new stable series kernels move the .x version
>> information somewhere more official.  I certainly do not mind throwing
>> together a patch to support DOTVERSION or what ever people want to 
>> call it.
>> Is anyone opposed to such a change?
> 
> 
> I think it will confuse scripts which expect something local in the 4th 
> field. I confess that I have such, and that field is turned into a 
> directory name during builds, so test results are saved in a proper 
> place. I think vendors and people who care will just keep three digits, 
> and those who want the last can make their EXTRAVERSION
>    2.Joes_Bar_&_Grill_486
> or whatever is needed.

There's also the LOCALVERSION that can be set in the config file.  I've 
switched to using that, since it means one less kernel patch to port.

Chris
