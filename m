Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVFVUbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVFVUbl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 16:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVFVUZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 16:25:16 -0400
Received: from mail.dvmed.net ([216.237.124.58]:48559 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262057AbVFVUX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 16:23:29 -0400
Message-ID: <42B9C8AB.8040001@pobox.com>
Date: Wed, 22 Jun 2005 16:23:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
CC: Greg Stark <gsstark@mit.edu>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [SATA] libata-dev queue updated
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com>	<42A1E96C.6080806@pobox.com> <20050604185028.GZ4992@stusta.de>	<42A1FB91.5060702@pobox.com> <87psv2j5mb.fsf@stark.xeocode.com>	<20050604191958.GA13111@havoc.gtf.org> <87k6l9k0aa.fsf@stark.xeocode.com> <42A263BB.9070606@pobox.com> <42B98EBF.7020500@rtr.ca>
In-Reply-To: <42B98EBF.7020500@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
> 
>> Greg Stark wrote:
>>
>>> So, uh, where do I get git? Where is your "git repository" and Linus' 
>>> "git repository" and how do I set that up?
>>
>>
>> http://lkml.org/lkml/2005/5/26/11
>>
>>     Jeff
> 
> 
> Okay, so now I have two separate git repositories,
> one for Linus's tree (currently at 2.6.12), and another
> that is Jeff's libata-dev bundle of goodies.
> 
> But I have no idea whatsoever what to do next.
> 
> What I *want*, is the patchset for "passthru",
> so that I can apply those patches to 2.6.12 and
> then test that kernel.
> 
> But it is nowhere even remotely close to possibly perhaps
> someday eventually maybe suggestively obvious how to do that.

Boy that's an unparseable sentence, if I ever saw one :)

You can obtain a patch from the 'passthru' branch by doing

	git checkout -f passthru
	git-diff-tree -p master HEAD > /tmp/patch

or simply by downloading what I just uploaded a few minutes ago,

http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.12-git4-passthru1.patch.bz2

