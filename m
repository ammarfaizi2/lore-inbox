Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263465AbTDGOOU (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbTDGOOU (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:14:20 -0400
Received: from smtp02.web.de ([217.72.192.151]:13344 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263465AbTDGOOR (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 10:14:17 -0400
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: compile error with 2.5.66-ac2
Date: Mon, 7 Apr 2003 16:25:47 +0200
User-Agent: KMail/1.5
References: <20030407122310.22b2023a.hv@trust-mart.com.cn>
In-Reply-To: <20030407122310.22b2023a.hv@trust-mart.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200304071624.01993.freesoftwaredeveloper@web.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 April 2003 06:12, hv wrote:
> arch/i386/kernel/apic.c: In function `setup_local_APIC':
> arch/i386/kernel/apic.c:454: unrecognizable insn:
> (insn 541 1623 1624 (set (strict_low_part (reg:QI 2 cl [58]))
>         (const_int 0 [0x0])) -1 (insn_list:REG_DEP_OUTPUT 530 (nil))
>     (nil))
> arch/i386/kernel/apic.c:454: Internal compiler error in
> insn_default_length, at insn-attrtab.c:356
> Please submit a full bug report,
> with preprocessed source if appropriate.
> See <URL:http://bugzilla.redhat.com/bugzilla/> for instructions.
> make[1]: *** [arch/i386/kernel/apic.o] Error 1
> make: *** [arch/i386/kernel] Error 2

seems to be a gcc bug, isn't it? Have you tried a newer version of gcc?

Regards
Michael Buesch.

-- 
My homepage: http://www.8ung.at/tuxsoft
fighting for peace is like fu**ing for virginity

