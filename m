Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262842AbVHERij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262842AbVHERij (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 13:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbVHERij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 13:38:39 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:3245 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S262842AbVHERif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 13:38:35 -0400
Date: Fri, 5 Aug 2005 19:38:29 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Bodo Eggert <7eggert@gmx.de>, LKML <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: Regression: radeonfb: No synchronisation on CRT with linux-2.6.13-rc5
In-Reply-To: <1123195493.30257.75.camel@gaston>
Message-ID: <Pine.LNX.4.58.0508051935570.2326@be1.lrz>
References: <Pine.LNX.4.58.0508040103100.2220@be1.lrz> <1123195493.30257.75.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2005, Benjamin Herrenschmidt wrote:

> On Fri, 2005-08-05 at 00:03 +0200, Bodo Eggert wrote:
> > My CRT is out of sync after radeonfb from 2.6.13-rc5 is initialized. 
> > 2.6.12 does not show this behaviour.
> 
> I'm out of town at the moment, could you maybe diff radeonfb between
> working & non-working and CC me the diff ? I don't have my work stuff at
> hand not my kernel images so...

There were no changes in radeonfb.c, but I could trace to to 
CONFIG_PREEMPT. With _NONE, it works as expected.


-- 
There is no such thing as an atheist in a foxhole. 
