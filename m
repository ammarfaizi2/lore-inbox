Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTKHSqg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 13:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTKHSqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 13:46:35 -0500
Received: from dp.samba.org ([66.70.73.150]:27781 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261973AbTKHSqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 13:46:34 -0500
Date: Sun, 9 Nov 2003 05:43:05 +1100
From: Anton Blanchard <anton@samba.org>
To: Denis <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6-test6: nanosleep+SIGCONT weirdness
Message-ID: <20031108184305.GF3440@krispykreme>
References: <200311081946.28808.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311081946.28808.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I observe some strange behaviour in 2.6-test6 with this small program:

Something looks wrong with the syscall restart stuff in 2.6, I noticed it
when doing:

sleep 600

Then doing ctrl z; fg twice.

Happens on x86 and ppc32.

Anton
