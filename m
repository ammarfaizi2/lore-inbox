Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280601AbRKJSsp>; Sat, 10 Nov 2001 13:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280594AbRKJSsf>; Sat, 10 Nov 2001 13:48:35 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:2692 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S280585AbRKJSsR>;
	Sat, 10 Nov 2001 13:48:17 -0500
Message-ID: <3BED766B.BEBA6EB0@pobox.com>
Date: Sat, 10 Nov 2001 10:48:11 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@rug.ac.be>
CC: Linux-Kernel Development Mailinglist 
	<linux-kernel@vger.kernel.org>
Subject: Re: Networking: repeatable oops in 2.4.15-pre2
In-Reply-To: <20011110132139.A872@Zenith.starcenter>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Vermeulen wrote:

> J Sloan (jjs@pobox.com) wrote:
> > I have been running the 2.4.15-pre kernels and
> > have found an interesting oops. I can reproduce
> > it immediately, and reliably, just by issuing an ssh
> > command (as a normal user).
>
> I'm currently running Linux 2.4.15-pre2 and have no troubles with ssh. I can
> safely login onto other hosts, or issuing commands like
>         ssh -l someuser@somehost mutt
> or copy files
>         scp somefile someuser@somehost:
>
> I'm not using OpenSSH 3.0 yet (2.9p2). I'm not running any firewall or
> transparent proxying.

Thanks for the info, this is what I suspected -

only people running iptables appear to be
seeing this problem.

cu

jjs



