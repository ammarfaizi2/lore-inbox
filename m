Return-Path: <linux-kernel-owner+w=401wt.eu-S1947220AbWLHUje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947220AbWLHUje (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 15:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947242AbWLHUjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 15:39:33 -0500
Received: from gw.goop.org ([64.81.55.164]:36035 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947223AbWLHUjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 15:39:33 -0500
Message-ID: <4579CD80.1040302@goop.org>
Date: Fri, 08 Dec 2006 12:39:28 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PPC compiler error (redefinition of 'struct bug_entry')
References: <Pine.SOC.4.61.0612082059360.16172@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0612082059360.16172@math.ut.ee>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos wrote:
> This if from todays git (2006-12-08):
>
>   CC      arch/ppc/kernel/asm-offsets.s
> In file included from arch/ppc/include/asm/bug.h:97,
>                  from include/linux/kernel.h:18,
>                  from include/asm/system.h:7,
>                  from include/linux/list.h:9,
>                  from include/linux/signal.h:8,
>                  from arch/ppc/kernel/asm-offsets.c:11:
> include/asm-generic/bug.h:10: error: redefinition of 'struct bug_entry'
> make[1]: *** [arch/ppc/kernel/asm-offsets.s] Error 1
>   

Hm, what's your .config?

Hey, what's arch/pps/include/asm/bug.h?  Is your tree clean?

    J
