Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbUDCXRe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 18:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbUDCXRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 18:17:34 -0500
Received: from opersys.com ([64.40.108.71]:2567 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262035AbUDCXRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 18:17:33 -0500
Message-ID: <406F476D.8050002@opersys.com>
Date: Sat, 03 Apr 2004 18:23:25 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Amit <khandelw@cs.fsu.edu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.4.16
References: <1080849830.91ac1e3f85274@system.cs.fsu.edu>	<406C79E4.1060700@opersys.com> <1081012426.5c22c66499b13@system.cs.fsu.edu>	<406F21CB.8070908@opersys.com> <1081026049.f64d5288b5aaa@system.cs.fsu.edu> <406F2851.6050304@opersys.com> <003b01c419d0$67e59e50$af7aa8c0@VALUED65BAD02C>
In-Reply-To: <003b01c419d0$67e59e50$af7aa8c0@VALUED65BAD02C>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Amit wrote:
>    The patches got installed smoothly however, like in linux-2.4.19 this
> time the "Kernel Tracing" option didn't come up when I did "make xconfig". I
> copied the CONFIG_TRACE=m from my .config of linux-2.4.19. I hope this is
> correct.

No, this isn't the right way.

You need to enable relayfs support in "File Systems"->"Pseudo filesystems",
then you will be able to select "General setup"->"Linux Trace Toolkit support".

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

