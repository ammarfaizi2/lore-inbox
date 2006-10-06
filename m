Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWJFJnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWJFJnv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 05:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWJFJnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 05:43:51 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:19633 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S932145AbWJFJnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 05:43:50 -0400
Date: Fri, 6 Oct 2006 11:43:48 +0200
From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
To: Witold W?adys?aw Wojciech Wilk <witold.wilk@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to get the kernel to be more "verbose"?
Message-ID: <20061006094348.GB11065@informatik.uni-freiburg.de>
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	Witold W?adys?aw Wojciech Wilk <witold.wilk@gmail.com>,
	linux-kernel@vger.kernel.org
References: <98975a8b0610052234p3287ab8fr70335f858ba4583b@mail.gmail.com> <20061006073303.GA5105@cepheus.pub> <98975a8b0610060038t4d5dbd14ja348ce78351a93e3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98975a8b0610060038t4d5dbd14ja348ce78351a93e3@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Organization: Universitaet Freiburg, Institut f. Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Witold,

(I readded linux-kernel@vger.kernel.org to the Cc:.)

Witold W?adys?aw Wojciech Wilk wrote:
> 2006/10/6, Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>:
> >Witold W?adys?aw Wojciech Wilk wrote:
> >> I've tried using the /proc/config.gz provided by the default kernel,
> >> but to no avail.
> >Does this mean, you cannot find the config because /proc/config.gz
> >doesn't exist?  Then try /boot/config-2.6.8.  Maybe I misunderstood you?
> 
> No, I've used the config I had in the 2.6.8 (in proc/config.gz), but
> the SAME kernel 2.6.8 source compiled incorrectly. So I think this
> might be some glitch on my machine... because it is im possible to
> make a kernel that is always getting stuck in the same place.
Did you notice that Debian kernels are not vanilla but patched?
 
You can get the patches from http://packages.debian.org/

> >> Any help? Please point me at something, I am trying for two weeks
> >> already, and I cannot find any problems like mine. Thanks a lot for
> >> any help.
> >You can try the "initcall_debug" kernel parameter to see which init
> >functions are called.
> 
> I will use that then. I am quite new to debugging the kernel... My
> programming knowledge is still quite low ;) But I will try that today
> after work... I will write more. I need to get the Wi-Fi working ASAP.
Another thing that could help you is SysRQ, there is a request that
prints out a stack dump.

Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=5+choose+3
