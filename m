Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316619AbSE3Mqf>; Thu, 30 May 2002 08:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316621AbSE3Mqe>; Thu, 30 May 2002 08:46:34 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:15364 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316619AbSE3Mqd>; Thu, 30 May 2002 08:46:33 -0400
Date: Thu, 30 May 2002 14:46:20 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: missing bit from signal patches
In-Reply-To: <20020530220828.3c3192cd.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.21.0205301442410.17583-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 30 May 2002, Stephen Rothwell wrote:

> Is the following a more ugly hack than yours?

Yes. :)
The problem is copy_siginfo(), which wants to access struct siginfo.
Copy the m68k version of siginfo.h and try to compile that.

bye, Roman

