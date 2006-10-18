Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWJRBnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWJRBnp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 21:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWJRBnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 21:43:45 -0400
Received: from smtpout.mac.com ([17.250.248.182]:15047 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751317AbWJRBnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 21:43:45 -0400
In-Reply-To: <28bb77d30610171634l5db9d909v2c4cd12972e9d5@mail.gmail.com>
References: <28bb77d30610171634l5db9d909v2c4cd12972e9d5@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <90DB029B-222B-4D0C-8642-913CD81D5C9B@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Machine Check Exception on dual core Xeon
Date: Tue, 17 Oct 2006 21:43:20 -0400
To: Steven Truong <midair77@gmail.com>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 17, 2006, at 19:34:59, Steven Truong wrote:
> Hi, all.  I have this node of dual core Xeon 3.2 GHz, 4 Gig of RAM and
> kernel 2.16.18 on CentOS 4.3.  I got kernel panic and after setting up
> kdump/kexec I was able to capture the kdump core.
> I found out this message with crash to analyze the core dump:
>
> HARDWARE ERROR
> CPU 0: Machine Check Exception:                4 Bank 3:  
> 0000000000000000
> TSC 0
> This is not a software problem!
> Run through mcelog --ascii to decode and contact your hardware vendor

You missed the blatantly obvious error message:
"This is not a software problem!"

Immediately followed by:
"contact your hardware vendor"

Please follow that advice

Cheers,
Kyle Moffett
