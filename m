Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbTDDGJB (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 01:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263530AbTDDGJB (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 01:09:01 -0500
Received: from adsl-b3-72-208.telepac.pt ([213.13.72.208]:17024 "HELO
	puma-vgertech.no-ip.com") by vger.kernel.org with SMTP
	id S263529AbTDDGIz (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 01:08:55 -0500
Message-ID: <3E8D23E8.4060508@vgertech.com>
Date: Fri, 04 Apr 2003 07:19:20 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: erik@hensema.net
CC: linux-kernel@vger.kernel.org
Subject: Re: How to fix the ptrace flaw without rebooting
References: <200304030708_MC3-1-32C2-5A8A@compuserve.com> <slrnb8oaad.j0h.erik@bender.home.hensema.net>
In-Reply-To: <slrnb8oaad.j0h.erik@bender.home.hensema.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Erik Hensema wrote:
> 
> If you can't reboot to apply a security fix, you've got a serious problem.
> 
> A better fix in a running system is to simply disable dynamic module
> loading: echo /no/such/file > /proc/sys/kernel/modprobe
> At the very least you can be sure your machine won't crash this way ;-)
> 

IIRC, dynamic module loading is not required to exploit all the bugs 
present in ptrace. Luckly all the exploits floating around require kmod :)

Regards,
Nuno Silva

