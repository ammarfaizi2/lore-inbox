Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbTJRPQW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 11:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbTJRPQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 11:16:22 -0400
Received: from wiggis.ethz.ch ([129.132.86.197]:27610 "EHLO wiggis.ethz.ch")
	by vger.kernel.org with ESMTP id S261649AbTJRPQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 11:16:20 -0400
From: Thom Borton <borton@phys.ethz.ch>
To: Peter Romba <promba@purdue.edu>, linux-kernel@vger.kernel.org
Subject: Re: Help a newbie:  "make modules_install" causes depmod errors for EVERY module on EVERY kernel I try?
Date: Sat, 18 Oct 2003 17:16:15 +0200
User-Agent: KMail/1.5.4
References: <3F9002FA.6030709@purdue.edu>
In-Reply-To: <3F9002FA.6030709@purdue.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310181716.15557.borton@phys.ethz.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What's the compiler version you use? Try gcc -v. If it's a 3.xx, then 
the kernel won't compile properly. If I am not mistaken, 2.95.4 is 
recommended.

Yours, Thom

On Friday 17 October 2003 16:55, Peter Romba wrote:
> For some reason I can't compile a kernel anymore.  I recently
> installed gnome 2.4 from source (the only major system change I can
> think of). Now when I try to compile 2.4.21, make modules_install
> gives depmod errors for EVERY module, even dummy.o in the case of
> an out-of-the-box kernel configuration.  This behavior happens on
> every kernel that I've tried.  This is using the typical make
> mrproper, make menuconfig, make dep, make clean, make bzImage, make
> modules, make modules_install sequence of stuff.
>
> In the process of building gnome I had to update ld from an RPM
> (couldn't install it from source, e-mail me if you want details on
> that).
>
> Any help would be greatly appreciated :)...  I'm at a loss about
> what to do.
>
> 	--Peter
> 	  promba@purdue.edu
>
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Thom Borton
Switzerland

