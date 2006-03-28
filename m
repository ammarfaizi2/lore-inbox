Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWC1Ivh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWC1Ivh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 03:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWC1Ivh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 03:51:37 -0500
Received: from mail.sw-soft.com ([69.64.46.34]:6835 "EHLO mail.sw-soft.com")
	by vger.kernel.org with ESMTP id S1751383AbWC1Ivg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 03:51:36 -0500
Message-ID: <4428F902.1020706@sw.ru>
Date: Tue, 28 Mar 2006 12:51:14 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: haveblue@us.ibm.com, linux-kernel@vger.kernel.org, devel@openvz.org,
       serue@us.ibm.com, akpm@osdl.org, sam@vilain.net,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pavel Emelianov <xemul@sw.ru>,
       Stanislav Protassov <st@sw.ru>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru>	<20060324211917.GB22308@MAIL.13thfloor.at> <m1psk7enfm.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1psk7enfm.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> so IMHO, we should make a kernel branch (Eric or Sam
>> are probably willing to maintain that), which we keep
>> in-sync with mainline (not necessarily git, but at 
>> least snapshot wise), where we put all the patches
>> we agree on, and each party should then adjust the
>> existing solution to this kernel, so we get some deep
>> testing in the process, and everybody can see if it
>> 'works' for him or not ...
> 
> ACK.  A collection of patches that we can all agree
> on sounds like something worth aiming for.
> 
> It looks like Kirill last round of patches can form
> a nucleus for that.  So far I have seem plenty of technical
> objects but no objections to the general direction.
yup, I will fix everything and will come with a set of patches for IPC, 
so we could select which way is better to do it :)

> So agreement appears possible.
Nice to hear this!

Eric, we have a GIT repo on openvz.org already:
http://git.openvz.org

we will create a separate branch also called -acked, where patches 
agreed upon will go.

Thanks,
Kirill
