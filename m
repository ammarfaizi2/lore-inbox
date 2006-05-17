Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWEQQPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWEQQPV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 12:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWEQQPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 12:15:21 -0400
Received: from terminus.zytor.com ([192.83.249.54]:3021 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750783AbWEQQPV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 12:15:21 -0400
Message-ID: <446B4BF9.4000800@zytor.com>
Date: Wed, 17 May 2006 09:14:49 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
CC: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       akpm@osdl.org
Subject: Re: klibc build broken on UML
References: <E1FgNkr-00024G-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1FgNkr-00024G-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> [resent because prev. post bounced on hpa and akpm due to mail problems here]
> 
> I get this on 2.6.17-rc4-mm1:
> 
>   CHK     include/linux/compile.h
> /usr/src/quilt/linux/scripts/Kbuild.klibc:60: /usr/src/quilt/linux/usr/klibc/arch/um/MCONFIG: No such file or directory
> usr/klibc/Kbuild:71: usr/klibc/arch/um/Makefile.inc: No such file or directory
> make[2]: *** No rule to make target `usr/klibc/arch/um/Makefile.inc'.  Stop.
> make[1]: *** [_usr_klibc] Error 2
> make: *** [usr] Error 2
> 
> Miklos

Known and fixed in my git tree already.

	-hpa
