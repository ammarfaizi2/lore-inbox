Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286508AbSAFAU3>; Sat, 5 Jan 2002 19:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286517AbSAFAUT>; Sat, 5 Jan 2002 19:20:19 -0500
Received: from junk.nocrew.org ([212.73.17.42]:30131 "EHLO junk.nocrew.org")
	by vger.kernel.org with ESMTP id <S286508AbSAFAUK>;
	Sat, 5 Jan 2002 19:20:10 -0500
To: paulus@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E3F8@IIS000>
	<15412.14140.652362.747279@argo.ozlabs.ibm.com>
	<854rm363x5.fsf@junk.nocrew.org>
	<15412.61172.824543.547728@argo.ozlabs.ibm.com>
	<857kqy4f5p.fsf@junk.nocrew.org>
	<15414.41241.254273.63930@argo.ozlabs.ibm.com>
From: Lars Brinkhoff <lars.spam@nocrew.org>
Organization: nocrew
Date: 06 Jan 2002 01:20:05 +0100
In-Reply-To: <15414.41241.254273.63930@argo.ozlabs.ibm.com>
Message-ID: <85advs2uve.fsf@junk.nocrew.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> writes:
> Wow, I didn't know that there was an extended PDP-10 architecture.
> It's 25 years since I did anything on a PDP-10. :)

Ok, the extended KL10 wasn't released until around 1978.

> Would you use 9-bit bytes or 8-bit bytes?

The char type is 9 bits by default.  There is also support for an
8-bit char type.  With four 8-bit chars in a word, the four least
signifiant bits are unused.

> If you use 9-bit bytes, I'm sure that somewhere in the kernel there
> will be some code that will break because it is assuming 8-bit
> bytes.

> Somehow I'm getting the feeling that your next message is going to
> say "actually, we have been running linux on the KL10 for the past 3
> years". :)

No, I'm not that sinister.  If there was a Linux port, I would have
told you already.  Anyway, we need to finish the GCC port first.

-- 
Lars Brinkhoff          http://lars.nocrew.org/     Linux, GCC, PDP-10
Brinkhoff Consulting    http://www.brinkhoff.se/    programming
