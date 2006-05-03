Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWECUfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWECUfB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 16:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWECUfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 16:35:01 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:29567 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750820AbWECUfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 16:35:00 -0400
Message-ID: <44591376.8030408@tmr.com>
Date: Wed, 03 May 2006 16:32:54 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060409 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: Kir Kolyshkin <kir@openvz.org>, sam@vilain.net,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, serue@us.ibm.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, herbert@13thfloor.at
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <1143228339.19152.91.camel@localhost.localdomain> <200603282029.AA00927@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <4429A17D.2050506@openvz.org> <443151B4.7010401@tmr.com> <443B873B.9040908@sw.ru> <4454BA24.4070204@tmr.com> <4455FEBE.9080304@sw.ru>
In-Reply-To: <4455FEBE.9080304@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
> Bill,
> 
>>> So I would detailed it like this:
>>> - freeze VPS
>>
>> when the VM stops providing services it's down as far as I'm concerned
> please, note, that connections are not dropped, new connections are not 
> responded with RESET and when VM is migrated all the clients are 
> serviced as if nothing has happened. From client point of view there is 
> only a small delay in servicing, but not a real downtime (when clients 
> are rejected). Maybe due to these some of people call it zero down-time. 
> Though from technical POV this is not the best term for sure. It is 
> better to call it checkpointing/restore or live migration.

With that I can agree. The argument that it's not down it's just 
unavailable isn't convincing. I think "live migration" is a really good 
description of what takes place, thanks for the nomenclature.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
