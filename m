Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285182AbRLFR0P>; Thu, 6 Dec 2001 12:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285183AbRLFR0F>; Thu, 6 Dec 2001 12:26:05 -0500
Received: from colorfullife.com ([216.156.138.34]:52230 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S285182AbRLFRZt>;
	Thu, 6 Dec 2001 12:25:49 -0500
Message-ID: <3C0FAA21.BF96E001@colorfullife.com>
Date: Thu, 06 Dec 2001 18:25:53 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jason Kohles <jkohles@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 + strace 4.4 + setuid programs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  If you want to strace setuid things and
> have the setuid bit honored, you have to run strace as root with the -u
> option.

No, even that's not possible anymore.
setuid is now always ignored if a process is ptraced, even if root
is ptracing - that's the fix for the latest ptrace root exploit
(2.4.1x).

--
	Manfred
