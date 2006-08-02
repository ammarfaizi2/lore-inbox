Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWHBCYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWHBCYg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 22:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWHBCYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 22:24:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52124 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751052AbWHBCYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 22:24:35 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Sam Ravnborg <sam@ravnborg.org>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 4/33] i386: CONFIG_PHYSICAL_START cleanup
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<11544302312298-git-send-email-ebiederm@xmission.com>
	<20060801190838.GB12573@mars.ravnborg.org>
Date: Tue, 01 Aug 2006 20:23:03 -0600
In-Reply-To: <20060801190838.GB12573@mars.ravnborg.org> (Sam Ravnborg's
	message of "Tue, 1 Aug 2006 21:08:38 +0200")
Message-ID: <m1zmenx4e0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

>> diff --git a/arch/i386/boot/compressed/head.S
> b/arch/i386/boot/compressed/head.S
>> index b5893e4..8f28ecd 100644
>> --- a/arch/i386/boot/compressed/head.S
>> +++ b/arch/i386/boot/compressed/head.S
>> @@ -23,9 +23,9 @@
>>   */
>>  .text
>>  
>> +#include <linux/config.h>
>
> You already have full access to all CONFIG_* symbols - kbuild includes
> it on the commandline. So please kill this include.

Ok.  That must be new.  No problem.

Eric
