Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293551AbSBZJZM>; Tue, 26 Feb 2002 04:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293550AbSBZJZD>; Tue, 26 Feb 2002 04:25:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48396 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293551AbSBZJYu>; Tue, 26 Feb 2002 04:24:50 -0500
Subject: Re: setsockopt(SOL_SOCKET, SO_SNDBUF) broken on 2.4.18?
To: Raphael_Manfredi@pobox.com (Raphael Manfredi)
Date: Tue, 26 Feb 2002 09:39:31 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a5feh2$bvs$1@lyon.ram.loc> from "Raphael Manfredi" at Feb 26, 2002 07:46:42 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fe55-0008UQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I can't use the returned value from getsockopt(SO_SNDBUF) to do a
> setsockopt(SO_SNDBUF), then it's broken!  You'll have a hard time convincing
> me otherwise.

I'd like to see a standards document cite for that. The behaviour we follow
is not atypical for a lot of ioctls and syscalls were you ask for one size
and the kernel gives you its preferred variant. In the other cases I can
think of the kernel also does not lie about its preferred variant
