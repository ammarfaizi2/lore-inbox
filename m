Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWDZEJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWDZEJT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 00:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWDZEJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 00:09:19 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:8321 "EHLO watts.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932356AbWDZEJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 00:09:18 -0400
Message-ID: <444EF25D.9070702@vilain.net>
Date: Wed, 26 Apr 2006 16:09:01 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: [RFC][PATCH 4/5] utsname namespaces: sysctl hack
References: <20060407095132.455784000@sergelap> <20060407183600.E40C119B902@sergelap.hallyn.com> <4446547B.4080206@sw.ru> <m1wtdlmvmr.fsf@ebiederm.dsl.xmission.com> <20060419175123.GD1238@sergelap.austin.ibm.com> <m1ejztjua2.fsf@ebiederm.dsl.xmission.com> <4446AF56.9060706@vilain.net> <20060425220022.GD7228@sergelap.austin.ibm.com>
In-Reply-To: <20060425220022.GD7228@sergelap.austin.ibm.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn wrote:

>>>Can we please suggest a syscall interface?
>>>      
>>>
>
>Eric,
>
>Did you have any ideas for how you'd want to interface to look?  Are
>you fine with the vserver approach?
>  
>

Eric has said that his understanding was that syscall switches (ie,
syscalls with subcommands) were bad form.

I understand the concern, but I think while it's still in prototype
stages, that it's a sensible and pragmatic approach. Once individual
subcommands are "finalised" then they can be split out into a seperate
syscall, and any level of backwards compatibility can be maintained by
whoever needs it.

>>What was wrong with the method of the one I posted / extracted from the
>>Linux-VServer project? I mean, apart from the baggage which I intend to
>>remove for the next posting.
>>    
>>
>
>Are you working on a next posting?
>  
>

I've been a bit backlogged of late. I'll put some time towards it this
week, of course patches are always welcome and will find a home on utsl :).

Sam.
