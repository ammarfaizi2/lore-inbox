Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWEPTU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWEPTU1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 15:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWEPTU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 15:20:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52110 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751018AbWEPTU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 15:20:26 -0400
Date: Tue, 16 May 2006 12:23:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: events/0 eats 100% cpu on core duo laptop
Message-Id: <20060516122303.48b14dc1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605162002150.9606@tassadar.physics.auth.gr>
References: <Pine.LNX.4.64.0605162002150.9606@tassadar.physics.auth.gr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitris Zilaskos <dzila@tassadar.physics.auth.gr> wrote:
>
> I have installed Slackware 10.2 on a fujitsu siemens e8110 laptop (Core 
> Duo). With 2.6.16.12 & 2.6.16.16 kernels, a few minutes after 
> boot events/0 starts eating 100% cpu (affecting performance and battery 
> life).
>  	Any ideas ?

Hit alt-sysrq-P.  That'll tell you where the CPU is spinning.  You might need
to hit it a few times to make sure you got the right CPU (if only one is
spinning).

You might need to do `echo 1 > /proc/sys/kernel/sysrq' to enable sysrq.
