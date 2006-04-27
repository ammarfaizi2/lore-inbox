Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751686AbWD0VXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbWD0VXa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 17:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWD0VXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 17:23:30 -0400
Received: from smtp-out.google.com ([216.239.33.17]:62198 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751685AbWD0VXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 17:23:30 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=OFuAwgP35iIqte70hQ6lxt/sInaS+8eRhG1ypSvAeAhubRAz0qxCbfK8EhXzNeW5g
	yUBJbIpOirrlQDc/V6Fsg==
Message-ID: <44513624.4040801@google.com>
Date: Thu, 27 Apr 2006 14:22:44 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org
Subject: Re: checklist (Re: 2.6.17-rc2-mm1)
References: <20060427014141.06b88072.akpm@osdl.org> <200604272156.11606.ak@suse.de> <445130E7.3060402@google.com> <200604272211.41923.ak@suse.de>
In-Reply-To: <200604272211.41923.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thursday 27 April 2006 23:00, Martin Bligh wrote:
> 
>>>Some Unixes have a cstyle(1). Maybe there is a free variant of it
>>>somewhere. But such a tool might put a lot of people on l-k out of job @)
>>
>>heh. we could do some basic stuff at least. run through lindent, and see
>>if it changes ;-)
> 
> Good luck weeding out the false positives from that.

Yes, I was joking.

>>Can't tell whether that was meant to be positive or negative feedback.
>>All this would require is "email patch to test-thingy@test.kernel.org".
> 
> 
> I meant it would be better if it happened automatically when the patch
> is submitted through the normal channels.

It would, and it pretty much does right now, in that we test -mm
(OK, we don't run sparse, but that's easy to fix). What I was trying to
do was take the burden off Andrew for handling the testing of every
single patch, which means getting the developer to deal with it.
Personally, I don't think "please email your patch in for automated
testing" is too much to ask from them.

It'd be easy to make the automated tester forward it to Andrew or
whatever, if it passed the tests.

M.
