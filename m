Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422820AbWBNVxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422820AbWBNVxt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422823AbWBNVxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:53:49 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:49056
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1422820AbWBNVxs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:53:48 -0500
Subject: Re: [PATCH 02/12] hrtimer: fix multiple macro argument expansion
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <Pine.LNX.4.61.0602141110450.3700@scrub.home>
References: <Pine.LNX.4.61.0602141110450.3700@scrub.home>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 22:54:20 +0100
Message-Id: <1139954060.2480.533.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-14 at 11:10 +0100, Roman Zippel wrote:
> For two macros the arguments were expanded twice, change them to inline
> functions to avoid it.
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
> Acked-by: Ingo Molnar <mingo@elte.hu>

Acked-by: Thomas Gleixner <tglx@linutronix.de>


