Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268281AbTCFTdi>; Thu, 6 Mar 2003 14:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268290AbTCFTdi>; Thu, 6 Mar 2003 14:33:38 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:55186 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S268281AbTCFTdh>; Thu, 6 Mar 2003 14:33:37 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 6 Mar 2003 11:52:42 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: HT and idle = poll
In-Reply-To: <b487l2$1tn$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.50.0303061150250.1670-100000@blue1.dev.mcafeelabs.com>
References: <200303052318.04647.habanero@us.ibm.com> <b487l2$1tn$1@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003, Linus Torvalds wrote:

> But yes, at least for now, I really don't think you should really _ever_
> use "idle=poll" on HT-enabled hardware. The idle CPU's will just suck
> cycles from the real work.

Not only. The polling CPU will also shoot a strom of memory requests,
clobbering the CPU's memory I/O stages.



- Davide

