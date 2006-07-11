Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWGKOyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWGKOyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWGKOyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:54:39 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:63352 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750872AbWGKOyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:54:38 -0400
Subject: Re: [PATCH -mm 2/7] add execns syscall to s390
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <44B3B95E.6020206@fr.ibm.com>
References: <20060711075051.382004000@localhost.localdomain>
	 <20060711075409.113248000@localhost.localdomain>
	 <1152625488.18034.13.camel@localhost>  <44B3B95E.6020206@fr.ibm.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Tue, 11 Jul 2006 16:54:35 +0200
Message-Id: <1152629675.18034.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 16:44 +0200, Cedric Le Goater wrote:
> Thanks !
> 
> Both patches are in my patchset now which compiles and boots fine on s390x.
> I'll build 32 bits binaries to try them.
> 
> Why did you protect sys32_execns, sys_execns and compat_do_execns () with
> #ifdef CONFIG_UTS_NS ? Did you need to ?

Yes, without the #ifdefs I get compile time warnings.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


