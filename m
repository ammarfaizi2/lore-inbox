Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266615AbUGKP2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266615AbUGKP2o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 11:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266616AbUGKP2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 11:28:43 -0400
Received: from modemcable053.53-202-24.mc.videotron.ca ([24.202.53.53]:13184
	"EHLO omega3.sco.ath.cx") by vger.kernel.org with ESMTP
	id S266615AbUGKP2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 11:28:42 -0400
Message-ID: <40F15CB7.2090802@yahoo.ca>
Date: Sun, 11 Jul 2004 11:28:55 -0400
From: Jonathan Filiatrault <lintuxicated@yahoo.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040528
X-Accept-Language: en-ca, fr-ca
MIME-Version: 1.0
To: Daniel Schmitt <pnambic@unu.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.7] Ehci controller interrupts like crazy on nforce2
References: <40EDF209.70707@yahoo.ca> <200407111409.09405.pnambic@unu.nu>
In-Reply-To: <200407111409.09405.pnambic@unu.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I've seen this problem on my board (Epox 8RDA3+) as well. The root cause seems 
>
>to be interrupt link devices enabled without regard for the actual device 
>status. A recent patch that delayed IRQ assignment to device activiation time 
>fixed this for me; you might want to try a fresh -mm or -bk kernel.
>
2.6.7-bk21 fixed this problem for me, thanks

>
>Hope that helps,
>
it sure did.

Happy Hacking,
Joe
