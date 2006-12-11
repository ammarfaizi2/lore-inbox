Return-Path: <linux-kernel-owner+w=401wt.eu-S1762601AbWLKApp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762601AbWLKApp (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 19:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762606AbWLKApo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 19:45:44 -0500
Received: from gw.goop.org ([64.81.55.164]:38332 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762601AbWLKApo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 19:45:44 -0500
Message-ID: <457CAA37.9040407@goop.org>
Date: Sun, 10 Dec 2006 16:45:43 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: w41ter@gmail.com, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>
Subject: Re: 2.6.19-rc6-mm2 hangs when gdb is run on a multithread program
References: <20061211000724.GA2578@ai.larroy.com>
In-Reply-To: <20061211000724.GA2578@ai.larroy.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pedro Larroy Tovar wrote:
> Hi
>
> I can reproduce a crash with 2.6.19-rc6-mm2 triggered when debugging a
> program with gdb that uses pthreads. No oops or anything strange seems
> to be printed by the kernel, but the box appears to stop doing disk IO.
>   

Hm, I wonder if this is related walt's problem running things under gdb?

Pedro, do you ever see oops or BUG messages?

Thanks,
    J
