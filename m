Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbUCDXck (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 18:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbUCDXck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 18:32:40 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:50675 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261967AbUCDXch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 18:32:37 -0500
Message-ID: <4047BC70.5050109@nortelnetworks.com>
Date: Thu, 04 Mar 2004 18:32:00 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mariusz Mazur <mmazur@kernel.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
References: <200402291942.45392.mmazur@kernel.pl> <200403042149.36604.mmazur@kernel.pl> <40479F3C.1010703@nortelnetworks.com> <200403042352.28592.mmazur@kernel.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mariusz Mazur wrote:
> On Thursday 04 of March 2004 22:27, Chris Friesen wrote:
> 
>>And how do you propose to handle a kernel developer that wants to add a
>>new feature (a scheduling class, for instance) and make it available to
>>userspace apps?
>>
> 
> Dunno. That's something one should ask the glibc people.

That's exactly my point.  I don't *want* to have to ask the glibc people.

I want to have the kernel ABI headers ship with the kernel, and only 
with the kernel.

I want to be able to change one header file, recompile my kernel, 
recompile my app, reboot, and pick up the change.  glibc should not even 
be a factor.

Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

