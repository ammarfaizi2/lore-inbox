Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262791AbRE3NsJ>; Wed, 30 May 2001 09:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262809AbRE3Nrt>; Wed, 30 May 2001 09:47:49 -0400
Received: from [216.221.199.130] ([216.221.199.130]:33035 "HELO mail.oeone.com")
	by vger.kernel.org with SMTP id <S262791AbRE3Nrn>;
	Wed, 30 May 2001 09:47:43 -0400
Message-ID: <3B14FAC0.6010901@oeone.com>
Date: Wed, 30 May 2001 09:50:56 -0400
From: Masoud Sharbiani <masouds@oeone.com>
Organization: OEone Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; rv:0.9) Gecko/20010516
X-Accept-Language: en
MIME-Version: 1.0
To: Nico Schottelius <nicos@pcsystems.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ PATCH ]: disable pcspeaker kernel: 2.4.2 - 2.4.5
In-Reply-To: <Pine.LNX.4.33.0105301414080.6313-200000@localhost.localdomain> <3B14ECF7.937C2A8@pcsystems.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!



> And what about the code from kernel/sys.c ?
> The version you provided doesn't take care of what's
> the default value of pcspeaker. This would make it
> undefined, which is not really good.


Since the variable is global in kernel/sysctl.c (and not kernel/sys.c),
and globals are set to zero when linking by GCC. (am I wrong?).
cheers,

Masoud





