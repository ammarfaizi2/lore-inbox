Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263870AbTLJSMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 13:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263883AbTLJSMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 13:12:09 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:24478 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S263870AbTLJSMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 13:12:06 -0500
Subject: Re: PPP over ttyUSB (visor.o, Treo)
From: Stian Jordet <liste@jordet.nu>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031210165540.B26394@fi.muni.cz>
References: <20031210165540.B26394@fi.muni.cz>
Content-Type: text/plain
Message-Id: <1071079933.4348.0.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Dec 2003 19:12:14 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ons, 10.12.2003 kl. 16.55 skrev Jan Kasprzak:
> 	Hello @subscribers,
> 
> does anybody have working PPP over ttyUSB device in 2.6 kernels?
> When I connect the Handspring Treo to the 2.6.0-test11 machine,
> I am able to synchronize it, but not to run PPP to it (it can work
> as modem). I am able to dial the modem connection using AT commands,
> but I am not able to run PPP over it. Firstly the chat(1) program
> complains about not being able to get terminal attributes (TCGETATTR,
> from strace output), and then pppd(8) complains about not being able
> to set terminal attributes (TCSETATTR from the strace output).
> In 2.4 the same setup works OK.
> 
> 	Any hints? (Kernel config and other details are available
> on request). Thanks,

Try to run pppd with "nodetach". Don't ask me why, but it works for me.

Best regards,
Stian

