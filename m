Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWBWOBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWBWOBp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 09:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWBWOBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 09:01:45 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:45482 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751244AbWBWOBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 09:01:44 -0500
Message-ID: <43FDBFFF.7010201@openvz.org>
Date: Thu, 23 Feb 2006 17:00:31 +0300
From: Kir Kolyshkin <kir@openvz.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Kir Kolyshkin <kir@openvz.org>, devel@openvz.org,
       Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>, Andrey Savochkin <saw@sawoct.com>,
       alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mrmacman_g4@mac.com, Linus Torvalds <torvalds@osdl.org>,
       frankeh@watson.ibm.com, serue@us.ibm.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [Devel] Re: Which of the virtualization approaches is more suitable
 for kernel?
References: <43F9E411.1060305@sw.ru>	<20060220161247.GE18841@MAIL.13thfloor.at> <43FB3937.408@sw.ru>	<20060221235024.GD20204@MAIL.13thfloor.at>	<43FC3853.9030508@openvz.org>	<m1zmkjjty6.fsf@ebiederm.dsl.xmission.com>	<43FDA46E.2000705@openvz.org> <m11wxujjg9.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m11wxujjg9.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>>That reflects our internal organization: we have a core virtualization team
>>which comes up with a core patch (combining all the stuff), and a maintenance
>>team which can add some extra patches (driver updates, some bugfixes). So that
>>extra patches comes up as a separate patches in src.rpms, while virtualization
>>stuff comes up as a single patch. That way it is easier for our maintainters
>>group.
>>
>>Sure we understand this is not convenient for developers who want to look at our
>>code -- and thus we provide broken-out kernel patch sets from time to time (not
>>for every release, as it requires some effort from Kirill, who is really buzy
>>anyway). So, if you want this for a specific kernel -- just ask.
>>
>>I understand that this might look strange, but again, this reflects our internal
>>development structure.
>>    
>>
>
>There is something this brings up.  Currently OpenVZ seems to be a
>project where you guys do the work and release the source under the
>GPL.  Making it technically an open source project.  However at the
>development level it does not appear to be a community project, at
>least at the developer level.
>
>There is nothing wrong with not doing involving the larger community
>in the development, but what it does mean is that largely as a
>developer OpenVZ is uninteresting to me.
>  
>
I though that first thing that makes particular technology interesting 
or otherwise appealing to developers is the technology itself, i.e. is 
it interesting, appealing, innovative and superior, is it tomorrow today 
and so on. From that point, OpenVZ is pretty much interesting. From the 
point of openness -- well, you might be right, there's still something 
we could do.

I understand it should work both ways -- we should provide easier ways 
to access the code, to contribute etc. Still, I see little to no 
interest of contributing to OpenVZ kernel. Probably this is because of 
high entry level, probably it is because we are not yet open enough or so.

Any way, I would love to hear any comments/suggestions of how we can 
improve this situation from our side (and let me express hope you will 
improve it from yours:)).

Regards,
  Kir.
