Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267521AbUJBTlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267521AbUJBTlL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 15:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267526AbUJBTlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 15:41:10 -0400
Received: from zero.aec.at ([193.170.194.10]:19982 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267521AbUJBTlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 15:41:08 -0400
To: Florian.Bohrer@t-online.de (Florian Bohrer)
cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH] AES x86-64-asm impl.
References: <2KWl4-wq-25@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 02 Oct 2004 21:41:00 +0200
In-Reply-To: <2KWl4-wq-25@gated-at.bofh.it> (Florian Bohrer's message of
 "Sat, 02 Oct 2004 20:00:18 +0200")
Message-ID: <m3acv4zz5f.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian.Bohrer@t-online.de (Florian Bohrer) writes:

> hi,
>
> this is my first public kernel patch. it is an x86_64 asm optimized version of AES for the 
> crypto-framework. the patch is against 2.6.9-rc2-mm1 but should work with other 
> versions too. 
>
>
> the asm-code is from Jari Ruusu (loop-aes).
> the org. glue-code is from Fruhwirth Clemens.
>

Thanks. I will add it to the x86-64 patchkit. I have a 64bit version 
here too, but it had a bug somewhere and I didn't have time to fix it yet.

Unfortunately it's still fundamentally 32bit. Anybody interested
in doing a true 64bit AES? 

-Andi


