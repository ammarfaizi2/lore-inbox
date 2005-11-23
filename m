Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbVKWQWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbVKWQWh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVKWQWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:22:37 -0500
Received: from gw-cistron.kwaak.net ([62.216.22.210]:12677 "EHLO
	mail.kwaak.net") by vger.kernel.org with ESMTP id S1751038AbVKWQWg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:22:36 -0500
Date: Wed, 23 Nov 2005 17:22:16 +0100
To: Patrizio Bassi <patrizio.bassi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG 2579] linux 2.6.* sound problems
Message-ID: <20051123162216.GG1700@kwaak.net>
References: <53L1x-6dC-13@gated-at.bofh.it> <53LkE-6QU-5@gated-at.bofh.it> <53LkW-6QU-49@gated-at.bofh.it> <53LEq-7gr-7@gated-at.bofh.it> <43667406.9070104@gmail.com> <4366A49F.3000101@rainbow-software.org> <43673B6F.5030909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43673B6F.5030909@gmail.com>
User-Agent: Mutt/1.5.6+20040907i
From: Ard van Breemen <ard@kwaak.net>
X-kwaak-MailScanner: Found to be clean
X-kwaak-MailScanner-SpamCheck: not spam, SpamAssassin (score=-5.29,
	required 5, autolearn=not spam, ALL_TRUSTED -3.30, AWL 0.61,
	BAYES_00 -2.60)
X-MailScanner-From: ard@kwaak.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 10:54:55AM +0100, Patrizio Bassi wrote:
> i played a bit with bios, but no luck.
> considering that in my windows copy i have no problems, i'm sure it's
> linux 2.6
> 
> update: can't use linux 2.4, i have nptl only and acpi problems too.
> i'll play with timers and latency
One more suggestion:
try running distributed-net or something else that uses 100% cpu.
I also have "bad sound" from on-board audio (hp nx9110 notebook
and some elcheap asus motherboard). Usually it is a bad or cheap
motherboard design.
If using your CPU 100% fixes or mostly diminishes your audio
distortion, you can be 100% sure that the audio part has a very
bad design (no separate voltage controllers or good power supply
filters, and no separate power supply circuit, and of course a
good deal of crosstalk between analog lines and "digital" lines).

-- 
begin  LOVE-LETTER-FOR-YOU.txt.vbs
I am a signature virus. Distribute me until the bitter
end
