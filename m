Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSFDUn5>; Tue, 4 Jun 2002 16:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316794AbSFDUn4>; Tue, 4 Jun 2002 16:43:56 -0400
Received: from www.transvirtual.com ([206.14.214.140]:34565 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S316792AbSFDUnz>; Tue, 4 Jun 2002 16:43:55 -0400
Date: Tue, 4 Jun 2002 13:43:40 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Miles Lane <miles@megapathdsl.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 -- Hanging (no oops and sysrq fails) after switching to
 rivafb
In-Reply-To: <20020604212747.C32338@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0206041343190.1200-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If you're seeing this then your /usr/include/{asm,linux} are symlinks to
> your current kernel source.  These directories must contain a copy of
> the kernel header files that were used to build glibc with, not the
> copy that came with the kernel you're currently running.
>
> (Please note: this is a FAQ - there's probably even a FAQ entry for it.)

Ug. I never had that happen before. Thanks. Problem fixed.

