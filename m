Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbULSOJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbULSOJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 09:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbULSOJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 09:09:28 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:55537 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261296AbULSOJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 09:09:16 -0500
Message-ID: <33506044.1103465322122.JavaMail.tomcat@pne-ps2-sn1>
Date: Sun, 19 Dec 2004 15:08:42 +0100 (MET)
From: Voluspa <lista4@comhem.se>
Reply-To: lista4@comhem.se
To: kernel@kolivas.org
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, mr@ramendik.ru,
       linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain;charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: CP Presentation Server
X-clientstamp: [213.64.150.229]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ARGH... I hate my ISPs new webmail. Disregard previous change of Topic.

On 2004-12-18 23:02:33 Con Kolivas wrote:

> Try disabling the swap token
> 
> echo 0 > /proc/sys/vm/swap_token_timeout

Hi Con. It changes the behaviour of my testcase, yes, but it doesn't cure the 
problem. When swap_token_timeout is the default 300 the screen freezes are 
longer in duration, about 30 seconds. With a swap_token_timeout of 0, max 
screen freezeis about 10 seconds, inter-foliated with freezes of less length.

On a positive note, the _total_ time of "unstability" is equal in both cases. 
Which in my animation test means 6 minutes. I said 3 previously, but that 
was wrong. Didn't let it run long enough.

Cheers,
Mats Johannesson

