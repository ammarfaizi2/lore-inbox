Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285498AbSBKA2g>; Sun, 10 Feb 2002 19:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285589AbSBKA2Z>; Sun, 10 Feb 2002 19:28:25 -0500
Received: from dsl-213-023-038-214.arcor-ip.net ([213.23.38.214]:43960 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S285498AbSBKA2S>;
	Sun, 10 Feb 2002 19:28:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: How to check the kernel compile options ?
Date: Mon, 11 Feb 2002 01:29:54 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1020209131301.23246B-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020209131301.23246B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16a4Ly-0000EN-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 9, 2002 07:15 pm, Bill Davidsen wrote:
> On Wed, 6 Feb 2002, Randy.Dunlap wrote:
> 
> > I still prefer your suggestion to append it to the kernel image
> > as __initdata so that it's discarded from memory but can be
> > read with some tool(s).
> 
> The problem is that it make the kernel image larger, which lives in /boot
> on many systems. Putting it in a module directory, even if not a module,
> would be a better place for creative boot methods, of which there are
> many.

You don't seem to be clear on the concept of 'option'.

-- 
Daniel
