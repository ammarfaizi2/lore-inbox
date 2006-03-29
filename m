Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWC3U2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWC3U2u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWC3U2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:28:50 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:11289 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750832AbWC3U2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:28:42 -0500
Message-ID: <442AF486.1090706@tmr.com>
Date: Wed, 29 Mar 2006 15:56:38 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: Kirill Korotaev <dev@sw.ru>, Dave Hansen <haveblue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       serue@us.ibm.com, akpm@osdl.org,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pavel Emelianov <xemul@sw.ru>,
       Stanislav Protassov <st@sw.ru>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru>  <44242D4D.40702@yahoo.com.au>	 <1143228339.19152.91.camel@localhost.localdomain>	 <4428BB5C.3060803@tmr.com> <4428FB2B.8070805@sw.ru>	 <44294B33.3040507@tmr.com> <1143587258.6325.59.camel@localhost.localdomain>
In-Reply-To: <1143587258.6325.59.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:
> On Tue, 2006-03-28 at 09:41 -0500, Bill Davidsen wrote:
>>> It is more than realistic. Hosting companies run more than 100 VPSs in 
>>> reality. There are also other usefull scenarios. For example, I know 
>>> the universities which run VPS for every faculty web site, for every 
>>> department, mail server and so on. Why do you think they want to run 
>>> only 5VMs on one machine? Much more! 
>> I made no commont on what "they" might want, I want to make the rack of 
>> underutilized Windows, BSD and Solaris servers go away. An approach 
>> which doesn't support unmodified guest installs doesn't solve any of my 
>> current problems. I didn't say it was in any way not useful, just not of 
>> interest to me. What needs I have for Linux environments are answered by 
>> jails and/or UML.
> 
> We are talking about adding jail technology, also known as containers on
> Solaris and vserver/openvz on Linux, to the mainline kernel.
> 
> So, you are obviously interested!
> 
> Because of course, you can take an unmodified filesystem of the guest
> and assuming the kernels are compatible run them without changes.  I
> find this consolidation approach indispensible.
> 
The only way to assume kernels are compatible is to run the same distro. 
Because vendor kernels are sure not compatible, even running a 
kernel.org kernel on Fedora (for instance) reveals the the utilities are 
also tweaked to expect the kernel changes, and you wind up with a system 
which feels like wearing someone else's hat. It's stable but little 
things just don't work right.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

