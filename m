Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286871AbSA2Xlq>; Tue, 29 Jan 2002 18:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287109AbSA2Xkf>; Tue, 29 Jan 2002 18:40:35 -0500
Received: from panther.fit.edu ([163.118.5.1]:58086 "EHLO fit.edu")
	by vger.kernel.org with ESMTP id <S287307AbSA2Xjk>;
	Tue, 29 Jan 2002 18:39:40 -0500
Message-ID: <3C573428.3000404@fit.edu>
Date: Tue, 29 Jan 2002 18:45:44 -0500
From: Kervin Pierre <kpierre@fit.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020129
X-Accept-Language: en-us
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch tracking system.
In-Reply-To: <Pine.LNX.4.33L.0201290902100.32617-100000@imladris.surriel.com> <200201291156.g0TBudE28106@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Public patch tracking system/queue, maybe something derived from bugzilla.

(i) patches are sent to the maintainer and entered into the system.

(ii) reviewed patches are update appropriately, eg. ( "reject - untidy, 
please fix", "accept - expected version 2.4.18pre19" etc. )

(iii) patch versions, updates can be kept, as in mozilla's bugzilla 
site.  And comments on that patch can also be kept right along side the 
code.

Regardless of wether the current system is changed or not, the linux 
kernel would benefit from a central, searchable, public repository of 
patches.

The code is available, bugzilla has all this functionality today.

So here's hoping for a patchzilla.kernel.org :)

--Kervin



Denis Vlasenko wrote:
> On 29 January 2002 09:04, Rik van Riel wrote:
> 
>>On Mon, 28 Jan 2002, John Weber wrote:
>>
>>>I would be happy to serve as patch penguin, as I plan on collecting all
>>>patches anyway in my new duties as maintainer of www.linuxhq.com.
>>>
>>>we have the hardware/network capacity to serve as a limitless queue of
>>>waiting patches for Linus.
>>>
>>Please don't just accumulate stuff.
>>
> 
> Right. Accepting any patch is wrong policy. You'll be swamped.
> Patch must be marked "applies to 2.N.M", patch tracking system must check 
> that automagically.
> 
> Also each patch(set) can be commented by general public and by maintainers.
> If there is _no_ comment from any of _maintainers_ (i.e. it is not reviewed 
> or found too ugly to worth commenting) it is automatically dropped from the 
> system after some time.  This will force patch authors to care about code 
> quality.
> 
> If patch is too old (several releases behind) system can mail author(s):
> "Warning. Your patchset #3476346 needs rediffing. It will be dropped 
> otherwise"
> 
> These "small" details determine whether system is useful or just turns into 
> huge pile of patches of questionable value.
> --
> vda
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 



-- 
http://linuxquestions.org/ - Ask linux questions, give linux help.

