Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265351AbUAPOuB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 09:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUAPOuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 09:50:00 -0500
Received: from smtp.ncy.finance-net.fr ([62.161.220.65]:13063 "EHLO
	smtp.ncy.finance-net.fr") by vger.kernel.org with ESMTP
	id S265351AbUAPOtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 09:49:53 -0500
Date: Fri, 16 Jan 2004 15:49:51 +0100
From: Fabian Fenaut <fabian.fenaut@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031015 Debian/1.4-0jds2
X-Accept-Language: fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.1-mm4
References: <20040115225948.6b994a48.akpm@osdl.org>
In-Reply-To: <20040115225948.6b994a48.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Message-Id: <S265351AbUAPOtx/20040116144953Z+7697@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got an error compiling -mm4 :

   [...]
   CC [M]  drivers/media/video/ir-kbd-gpio.o
drivers/media/video/ir-kbd-gpio.c:185: unknown field `name' specified in
initializer
drivers/media/video/ir-kbd-gpio.c:185: warning: missing braces around
initializer
drivers/media/video/ir-kbd-gpio.c:185: warning: (near initialization for
`driver.drv')
drivers/media/video/ir-kbd-gpio.c:186: unknown field `drv' specified in
initializer
drivers/media/video/ir-kbd-gpio.c:187: unknown field `drv' specified in
initializer
drivers/media/video/ir-kbd-gpio.c:188: unknown field `gpio_irq'
specified in initializer
drivers/media/video/ir-kbd-gpio.c:188: warning: initialization from
incompatible pointer type
make[4]: *** [drivers/media/video/ir-kbd-gpio.o] Erreur 1
make[3]: *** [drivers/media/video] Erreur 2
make[2]: *** [drivers/media] Erreur 2
make[1]: *** [drivers] Erreur 2
make[1]: Leaving directory `/usr/src/linux-2.6.1'
make: *** [stamp-build] Erreur 2


Complete log : http://fabian.fenaut.free.fr/compile_error
.config : http://fabian.fenaut.free.fr/config-2.6.1-mm4

Any hint ?

Thank you
Fabian


Andrew Morton a écrit le 16.01.2004 07:59:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm4/

