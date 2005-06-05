Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVFEToA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVFEToA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 15:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVFETn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 15:43:59 -0400
Received: from mail.linicks.net ([217.204.244.146]:21260 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261331AbVFETn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 15:43:58 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: CPU type .config <-> i386/Makefile question[s]
Date: Sun, 5 Jun 2005 20:43:56 +0100
User-Agent: KMail/1.8.1
References: <200506051458.50307.nick@linicks.net> <20050605174322.GF4992@stusta.de>
In-Reply-To: <20050605174322.GF4992@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506052043.56547.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 June 2005 18:43, Adrian Bunk wrote:

> the specific reason is that kernel 2.4 is in a maintainance mode and
> such changes are not considered being worth the risk of breaking
> anything anywhere with any of the supported gcc versions.
>
> In kernel 2.6, this is already handled the way you expect it.
>
> > Also I notice that if I changed the top level Makefile to include my
> > specific CPU, then the i386/Makefile adds += -march=i686 to the build
> > lines AFTER CFLAGS~ thus the second one will take precedence (I guess)
> > anyway, and the -march CFLAG changes are basically over-ridden?
>
> Users are not expected to manually set any CFLAGS.
>
> It might work in your case, but unless you _really_ know what you are
> doing you always risk some breakage.

I see!  Thanks for info.  I can do my own patch to play with :-)

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
