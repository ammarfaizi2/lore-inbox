Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVAOBo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVAOBo1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVAOBmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:42:14 -0500
Received: from [81.2.110.250] ([81.2.110.250]:36585 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262069AbVAOBiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:38:01 -0500
Subject: Re: thoughts on kernel security issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Julian T. J. Midgley" <jtjm@xenoclast.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <cs8nhp$j2d$1@sea.gmane.org>
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	 <20050114102249.GA3539@wiggy.net> <cs8cqv$jo5$1@sea.gmane.org>
	 <871xcoxduk.fsf@deneb.enyo.de>  <cs8nhp$j2d$1@sea.gmane.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105745094.9839.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 15 Jan 2005 00:33:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-14 at 15:12, Julian T. J. Midgley wrote:
> You'll have to explain why leaking the information "that there is a
> bug in $PROGRAM", by fixing it (without disclosing either the bug or
> the fix), is a problem.  After all, you can assume that for every

Because the bad guys do keep watch and they do go looking and some of
them are very very bright people. Knowing application A has a bug
generally means you know the kind of bug because it'll be "flavour of
the month" bug. In other words most bugs are variants of the latest
exploit because everyone is now looking at every other app for the same
problem.

We had network buffer overflow period, multiplication/addition overflow
period, 2D maths overflow in image viewer period and so on..

Alan

