Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbUEPC5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUEPC5R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 22:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUEPC5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 22:57:17 -0400
Received: from amber.ccs.neu.edu ([129.10.116.51]:20644 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S262585AbUEPC5N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 22:57:13 -0400
Subject: Re: Linux 2.6.5 emu10k1 module FAILS, built-in OK.
From: Stan Bubrouski <stan@ccs.neu.edu>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405151530590.16044@p500>
References: <Pine.LNX.4.58.0405151530590.16044@p500>
Content-Type: text/plain
Message-Id: <1084676229.21547.0.camel@duergar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 15 May 2004 22:57:10 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-05-15 at 15:32, Justin Piszcz wrote:
> Script started on Sat May 15 14:47:08 2004
> # modprobe emu10k1
> FATAL: Error inserting emu10k1
> (/lib/modules/2.6.5/kernel/sound/oss/emu10k1/emu10k1.ko): Unknown symbol

Umm...why are you using OSS for emu10k instead of ALSA?

-sb

> in module, or unknown parameter (see dmesg)
> root@war:~# dmesg | tail -n 1
>  emu10k1: Unknown symbol strcpy
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

