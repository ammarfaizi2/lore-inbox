Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTJAIRy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 04:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbTJAIRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 04:17:54 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:1266 "EHLO
	natsmtp01.webmailer.de") by vger.kernel.org with ESMTP
	id S262033AbTJAIRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 04:17:53 -0400
Message-ID: <3F7A8E0F.9040903@softhome.net>
Date: Wed, 01 Oct 2003 10:19:27 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030831
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kartikey bhatt <kartik_me@hotmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can't X be elemenated?
References: <BGWr.3eL.7@gated-at.bofh.it>
In-Reply-To: <BGWr.3eL.7@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kartikey bhatt wrote:
> hey everyone who have joined this thread, my fundamental question have got
> out of scope. I mean to say
> 

   And we meant to answer.

> 1. Kernel level support for graphics device drivers.

   Already done. Look for DRI/DRM/framebuffer.

> 2. On top of that, one can develop complete lightweight GUI.

   That's not a kernel stuff - but it is already done - google around 
for microwindows nanogui - you will find links for light-weight GUIs.

   Bringing this into kernel space will make it only slower. On 
performance critical pathes people avoid simple calls - and you want to 
bring here system call...

> 3. Maybe kernel can provide support for event handling.

   Already in place for last two decades - poll()/select().

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--
   "... and for $64000 question, could you get yourself vaguely
      familiar with the notion of on-topic posting?"
				-- Al Viro @ LKML

