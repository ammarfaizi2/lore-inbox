Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267314AbUI0USD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267314AbUI0USD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUI0UPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:15:43 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:14814 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267326AbUI0UP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:15:26 -0400
Date: Mon, 27 Sep 2004 22:17:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Matt Heler <lkml@lpbproductions.com>
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4
Message-ID: <20040927201709.GA19257@elte.hu>
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <200409270706.21661.lkml@lpbproductions.com> <200409271131.27329.gene.heskett@verizon.net> <200409270940.39851.lkml@lpbproductions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409270940.39851.lkml@lpbproductions.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Matt Heler <lkml@lpbproductions.com> wrote:

> Yup, turning opff pre-emptable bkl makes it boot up and work just fine.

do you know which particular subsystem broke (by comparing the failed
and the successful bootlogs)? Could you boot with 'debug' on the boot
command line - do you get more messages around the hang that could
pinpoint the breakage?

	Ingo
