Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWGKOo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWGKOo7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWGKOo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:44:59 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:43155 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750925AbWGKOo6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:44:58 -0400
Message-ID: <44B3B95E.6020206@fr.ibm.com>
Date: Tue, 11 Jul 2006 16:44:46 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: schwidefsky@de.ibm.com
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 2/7] add execns syscall to s390
References: <20060711075051.382004000@localhost.localdomain>	 <20060711075409.113248000@localhost.localdomain> <1152625488.18034.13.camel@localhost>
In-Reply-To: <1152625488.18034.13.camel@localhost>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> On Tue, 2006-07-11 at 09:50 +0200, Cedric Le Goater wrote: 
>> This patch adds the execns() syscall to the s390 architecture.
> 
> Fixed whitespace and added glue code for compat_do_execns.
> 

Thanks !

Both patches are in my patchset now which compiles and boots fine on s390x.
I'll build 32 bits binaries to try them.

Why did you protect sys32_execns, sys_execns and compat_do_execns () with
#ifdef CONFIG_UTS_NS ? Did you need to ?

C?
