Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWGWOlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWGWOlm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 10:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWGWOlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 10:41:42 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:57860 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1750765AbWGWOll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 10:41:41 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Debugging APM - cat /proc/apm produces oops
Date: Sun, 23 Jul 2006 16:41:33 +0200
User-Agent: KMail/1.9.3
References: <200607231630.53968.linux@rainbow-software.org>
In-Reply-To: <200607231630.53968.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607231641.33495.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 July 2006 16:30, Ondrej Zary wrote:
> I've tried calling the APM 0x530A function from DOS (real mode, int 15h)
> and single-stepping the BIOS APM code (using good old user-friendly Turbo
> Debugger). Noticed some OUTs to 0xB1 (or something like that), then some
> PCI accesses (0xCF8 and 0xCFC) and then IP ended in area of all zeros. When
> I step over the int 15h call, it works fine - returns correct info.

Sorry, this was my bad. It works fine even when single stepping. I've made a 
mistake and stepped over the ending int 20h instruction of my .com program...

I'm probably going to write down complete sequence of instructions which get 
executed during the call.

-- 
Ondrej Zary
