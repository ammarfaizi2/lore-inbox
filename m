Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbVHWA51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbVHWA51 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 20:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbVHWA51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 20:57:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48275 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750728AbVHWA51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 20:57:27 -0400
To: Adrian Bunk <bunk@stusta.de>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>
Subject: Re: strange CRASH_DUMP dependencies
References: <20050821225310.GE5726@stusta.de>
	<20050822062302.GA4293@in.ibm.com> <20050822204417.GI9927@stusta.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 22 Aug 2005 18:56:49 -0600
In-Reply-To: <20050822204417.GI9927@stusta.de> (Adrian Bunk's message of
 "Mon, 22 Aug 2005 22:44:17 +0200")
Message-ID: <m18xyto4ha.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

>> > - Is there any sane reason for the dependency on EMBEDDED?
>> > 
>> 
>> I believe this was introduced because large servers can have huge amount
>> of memory (running into Tera Bytes) and saving all that memory might not be
>> practical. Hence it was perceived that until some filtering mechanism is
>> implemented, it is more suited for small systems.
>>...
>
> It seems you have a wrong impression of what EMBEDDED in the kernel 
> does.
>
> There is _not_ a choice EMBEDDED/WORKSTATION/SERVER.
>
> EMBEDDED is an option that shows "save space at any cost" options.
>
> It allows you to tell gcc to generate slower but faster code or to 
> deselect options in the "do this only if you _really_ know what you are 
> doing" class.

And at the moment that is where building a crashdump capture kernel falls.
"do this only if you really know what you are doing". 

Eric

