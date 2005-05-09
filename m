Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVEIIUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVEIIUe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 04:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVEIIUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 04:20:32 -0400
Received: from zork.zork.net ([64.81.246.102]:63213 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261167AbVEIIU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 04:20:29 -0400
From: Sean Neakums <sneakums@zork.net>
To: li nux <lnxluv@yahoo.com>
Cc: linux <linux-kernel@vger.kernel.org>
Subject: Re: NPTL: pid of a thread and gdb
References: <20050509050035.86058.qmail@web60518.mail.yahoo.com>
Mail-Followup-To: li nux <lnxluv@yahoo.com>, linux
	<linux-kernel@vger.kernel.org>
Date: Mon, 09 May 2005 09:17:14 +0100
In-Reply-To: <20050509050035.86058.qmail@web60518.mail.yahoo.com> (li nux's
	message of "Sun, 8 May 2005 22:00:34 -0700 (PDT)")
Message-ID: <6upsw0ak51.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

li nux <lnxluv@yahoo.com> writes:

> I am using the NPTL ilbrary to create a thread.
> In NPTL the parent and the thread have the same pid.
> Then on what basis gdb differentiates between the
> threads which have the same pid ?

See gettid(2).

-- 
Dag vijandelijk luchtschip de huismeester is dood
