Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTI0SNV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 14:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTI0SNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 14:13:21 -0400
Received: from [65.248.4.67] ([65.248.4.67]:28589 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S262131AbTI0SNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 14:13:16 -0400
Message-ID: <001001c38523$04422860$f8e4a7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Ingo Molnar" <mingo@elte.hu>, "Gabor MICSKO" <gmicsko@szintezis.hu>
Cc: <linux-kernel@vger.kernel.org>
References: <1064678738.3578.8.camel@sunshine> <Pine.LNX.4.56.0309271950450.21678@localhost.localdomain>
Subject: Re: [Test] exec-shield-2.6.0-test5-G2 vs. paxtest & libsafe
Date: Sat, 27 Sep 2003 15:13:11 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-XTmail: http://www.verdesmares.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

something like this:
www.bandnet.com.br/~breno_silva/Kernel_linux/sec_stack.c
www.bandnet.com.br/~breno_silva/Kernel_linux/sec_stack1.1v.c


att,
Breno
----- Original Message -----
From: "Ingo Molnar" <mingo@elte.hu>
To: "Gabor MICSKO" <gmicsko@szintezis.hu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Saturday, September 27, 2003 3:02 PM
Subject: Re: [Test] exec-shield-2.6.0-test5-G2 vs. paxtest & libsafe


>
> On Sat, 27 Sep 2003, Gabor MICSKO wrote:
>
> > Kernel:
> > Linux sunshine 2.6.0-test5-exec-shield-nptl #3 SMP 2003. sze. 27.,
> > szombat, 13.37.42 CEST i686 GNU/Linux
>
> thanks for the testing. The ELF loader changes had a bug which ended up in
> creating an extra executable page after .bss, failing some of the tests.
> I've fixed this, could you try the -G3 patch?:
>
>   redhat.com/~mingo/exec-shield/exec-shield-2.6.0-test5-G3
>   redhat.com/~mingo/exec-shield/exec-shield-2.6.0-test5-bk12-G3
>
> Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

