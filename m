Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270717AbTGUVmw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 17:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270731AbTGUVmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 17:42:52 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:64938 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S270717AbTGUVmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 17:42:51 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 IDE problems (lost interrupt, bad DMA status)
From: Ronald Wahl <Ronald.Wahl@informatik.tu-chemnitz.de>
Date: Mon, 21 Jul 2003 23:57:58 +0200
Message-ID: <m24r1fa6ft.fsf@rohan.middle-earth.priv>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Score: -1.0 (-)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19eifK-0004FO-00*Xmqwgtdj31A*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> joe briggs <jbriggs@briggsmedia.com> wrote:
> > Can anyone tell me what the -ac patches do with respect to this problem?  
> > Also, what functionality is lost when CONFIG_X86_IO_APIC is not set, and 
> > should it improve this hd timeout/lost interrupt problem?

> It fixes the problem where interrupts are lost when the relevant IRQ line
> is disabled.

I have 3 questions regarding this issue:

1. Can you explain the problem a little bit more in detail?

2. Is there a dedicated patch solving this issue? (I don't want to
   apply the complete -ac patch )

3. Will this patch be in 2.4.22?


Thx & regards,
ron

PS: Sorry if this mail is not part of the origin thread. I'm not on the
    list and read about the problem in a mailing list archive.
