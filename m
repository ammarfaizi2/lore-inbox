Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266315AbUAGV3H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 16:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266317AbUAGV3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 16:29:07 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:14096 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S266315AbUAGV3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 16:29:04 -0500
Date: Wed, 7 Jan 2004 22:30:46 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Nicolas Nilles" <nnilles@skycop.net>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, sensors@stimpy.netroedge.com
Subject: Re: Kernel 2.6.0 and i2c-viapro posible Bug
Message-Id: <20040107223046.093ea670.khali@linux-fr.org>
In-Reply-To: <OLEKJGKIEPMKIGIPLDBNCEKJCDAA.nnilles@skycop.net>
References: <OLEKJGKIEPMKIGIPLDBNCEKJCDAA.nnilles@skycop.net>
Reply-To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I thinks that thgere is  probably a bug in I2c-viapro module,
> cuz when i load i2c-viapro after loading w82781d, my computer  just
> put very slow..., i try loading as modules in the kernel or built in,
> in both cases i have the same problem.
>
> I use 2.6.0 Vanilla Kernel sources.
> Please i will really apreciate if some one responde to this
> mail, put my adress in the CC field please cuz i not in the LKML.
> If someone need another information about my computer, config..
> or somehting more, just ask for it.
>
> Thanks.

Tested this on my own system with similar hardware (as far as i2c is
concerned) under 2.6.1-rc2. I did not experience any slowdown.

Could you please provide the following information:

* Output of "lspci -n".

* Can you reproduce the problem with a 2.4.24 kernel and i2c+lm_sensors
  2.8.2?

* Can you reproduce the problem with a 2.6.1-rc2 kernel?

* Can you reproduce the problem without ACPI support enabled into your
  kernel?

* Does the slowdown affect only the hard-disk drive?

* Does the speed come back to normal if you remove i2c-viapro?

* Does the slowdown occur if you load i2c-viapro before w83781d?

Yeah, I know, this is much work, but we need a hint to start digging.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
