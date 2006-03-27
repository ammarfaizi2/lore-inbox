Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWC0Sst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWC0Sst (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 13:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWC0Sst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 13:48:49 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19088 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750823AbWC0Sst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 13:48:49 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org, devel@openvz.org,
       serue@us.ibm.com, akpm@osdl.org, sam@vilain.net,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pavel Emelianov <xemul@sw.ru>,
       Stanislav Protassov <st@sw.ru>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru>
	<20060324211917.GB22308@MAIL.13thfloor.at>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 27 Mar 2006 11:45:49 -0700
In-Reply-To: <20060324211917.GB22308@MAIL.13thfloor.at> (Herbert Poetzl's
 message of "Fri, 24 Mar 2006 22:19:17 +0100")
Message-ID: <m1psk7enfm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> On Fri, Mar 24, 2006 at 08:19:59PM +0300, Kirill Korotaev wrote:
>> Eric, Herbert,
>> 
>> I think it is quite clear, that without some agreement on all these
>> virtualization issues, we won't be able to commit anything good to
>> mainstream. My idea is to gather our efforts to get consensus on most
>> clean parts of code first and commit them one by one.
>>
>> The proposal is quite simple. We have 4 parties in this conversation
>> (maybe more?): IBM guys, OpenVZ, VServer and Eric Biederman. We
>> discuss the areas which should be considered step by step. Send
>> patches for each area, discuss, come to some agreement and all 4
>> parties Sign-Off the patch. After that it goes to Andrew/Linus. 
>> Worth trying?
>
> sounds good to me, as long as we do not consider
> the patches 'final' atm .. because I think we should
> try to test them with _all_ currently existing solutions
> first ... we do not need to bother Andrew with stuff
> which doesn't work for the existing and future 'users'.
>
> so IMHO, we should make a kernel branch (Eric or Sam
> are probably willing to maintain that), which we keep
> in-sync with mainline (not necessarily git, but at 
> least snapshot wise), where we put all the patches
> we agree on, and each party should then adjust the
> existing solution to this kernel, so we get some deep
> testing in the process, and everybody can see if it
> 'works' for him or not ...

ACK.  A collection of patches that we can all agree
on sounds like something worth aiming for.

It looks like Kirill last round of patches can form
a nucleus for that.  So far I have seem plenty of technical
objects but no objections to the general direction.

So agreement appears possible.

Eric
