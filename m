Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWDSVpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWDSVpF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 17:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWDSVpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 17:45:04 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:26010 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751251AbWDSVpD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 17:45:03 -0400
Message-ID: <4446AF56.9060706@vilain.net>
Date: Thu, 20 Apr 2006 09:44:54 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       xemul@sw.ru, James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 4/5] utsname namespaces: sysctl hack
References: <20060407095132.455784000@sergelap>	<20060407183600.E40C119B902@sergelap.hallyn.com>	<4446547B.4080206@sw.ru> <m1wtdlmvmr.fsf@ebiederm.dsl.xmission.com>	<20060419175123.GD1238@sergelap.austin.ibm.com> <m1ejztjua2.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ejztjua2.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>>Is it time to ask for the utsname namespace patch to be tried out
>>in -mm?
>>    
>>
>
>Can we please suggest a syscall interface?
>  
>

What was wrong with the method of the one I posted / extracted from the
Linux-VServer project? I mean, apart from the baggage which I intend to
remove for the next posting.

The concept was - have a single syscall with versioned subcommands. We
can throw all of the namespace syscalls in there.

Sam.
