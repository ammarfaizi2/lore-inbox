Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbTEGVim (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 17:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbTEGVim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 17:38:42 -0400
Received: from watch.techsource.com ([209.208.48.130]:4019 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S264298AbTEGVil
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 17:38:41 -0400
Message-ID: <3EB980AA.9060207@techsource.com>
Date: Wed, 07 May 2003 17:54:50 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Pollard <jesse@cats-chateau.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]> <03050716305002.07468@tabby>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jesse Pollard wrote:
> On Wednesday 07 May 2003 12:13, Jonathan Lundell wrote:
> [snip]
> 
>>One thing that would help (aside from separate interrupt stacks)
>>would be a guard page below the stack. That wouldn't require any
>>physical memory to be reserved, and would provide positive indication
>>of stack overflow without significant runtime overhead.
> 
> 
> It does take up a page table entry, which may also be in short supply

Now, I'm sure this has GOT to be a terribly ignorant question, but I'll 
try anyhow:

What happens if you simply neglect to provide a mapping for that page? 
I'm sure that will cause some sort of page fault.  Why would you have to 
do something different?

