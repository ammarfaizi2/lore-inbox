Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVEYXqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVEYXqX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 19:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVEYXqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 19:46:23 -0400
Received: from fire.osdl.org ([65.172.181.4]:30884 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261614AbVEYXqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 19:46:19 -0400
Date: Wed, 25 May 2005 16:47:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: cijoml@volny.cz
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-pm] potential pitfall? changing configuration while PC
 in hibernate (fwd)
Message-Id: <20050525164701.52a45680.akpm@osdl.org>
In-Reply-To: <200503212310.37801.cijoml@volny.cz>
References: <20050321184512.GA1390@elf.ucw.cz>
	<200503212310.37801.cijoml@volny.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Semler <cijoml@volny.cz> wrote:
>
> It is real stupid, that Linux kernel freezes when simply during hibernate I 
> change Bluetooth dongle to USB mouse in my USB port.
> 
> And it is not uncommon problem - I have BT dongle that starts in HID proxy 
> mode and then I switch it to HCI mode. So I hibernate with BT dongle and 
> after hibernate Linux only reads image from Swap and then freezes! :( Problem 
> is, that It delete image from swap imeditially after reading it, so when I 
> tried is simply with USB mouse (hibernate without it and plug it when 
> notebook was switched off) it doesn't read it from swap ever and I lost all 
> my memory :(
> 
> I can do nothing with this behavior of my dongle and there is no known way how 
> to switch it back to HID-proxy mode before hibernate (Marcel correct me if I 
> am wrong) - CSR based dongle D-Link with Apple firmware.
> 
> Windows knows it and doesn't have problem with it for 5 years! :)
> 
> Laptop is all Intel based, kernel 2.6.11.5-vanilla, gcc 3.4.3, Debian testing

Can you please retest 2.6.12-rc5, see if this bug is still there?

Thanks.
