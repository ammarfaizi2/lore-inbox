Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbTBST4G>; Wed, 19 Feb 2003 14:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264716AbTBST4G>; Wed, 19 Feb 2003 14:56:06 -0500
Received: from gw-yyz.somanetworks.com ([216.126.67.39]:53718 "EHLO
	somanetworks.com") by vger.kernel.org with ESMTP id <S264688AbTBST4F>;
	Wed, 19 Feb 2003 14:56:05 -0500
Date: Wed, 19 Feb 2003 15:06:00 -0500
From: Mark Frazer <mark@somanetworks.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: more than 2048 unix98 ptys?
Message-ID: <20030219150600.A22255@somanetworks.com>
References: <20030219141537.A21814@somanetworks.com> <Pine.LNX.3.95.1030219143104.10649A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.95.1030219143104.10649A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Wed, Feb 19, 2003 at 02:36:02PM -0500
X-Message-Flag: Outlook not so good.
Organization: Detectable, well, not really
X-Fry-1: And then when I feel so stuffed I can't eat any more, I just use
X-Fry-2: the restroom, and then I *can* eat more!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson <root@chaos.analogic.com> [03/02/19 14:38]:
> Read the comments in .../linux-n.n/include/linux/tty.h and then
> modify NR_PTYS accordingly. You need to add more majors as well.

I was hoping for something like the 32 bit dev_t that I've seen talked
about (but know very little about).  I need 16 or 32K ptys.  Getting that
many majors does not appear possible.

> Note that ptys are used for interactive terminals, you don't need
> one for every network connection. You may be adding something that
> you don't need and wasting kernel space.

It's for a PPP test client and we need a pty per session.

-- 
OK, but I don't want anyone thinking we're robosexuals. - Bender
