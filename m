Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264971AbSJOXDo>; Tue, 15 Oct 2002 19:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265129AbSJOXCV>; Tue, 15 Oct 2002 19:02:21 -0400
Received: from zero.aec.at ([193.170.194.10]:63506 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S264971AbSJOWui>;
	Tue, 15 Oct 2002 18:50:38 -0400
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [4/7] oprofile - NMI hook
References: <20021015223319.GD41906@compsoc.man.ac.uk>
From: Andi Kleen <ak@muc.de>
Date: 16 Oct 2002 00:56:28 +0200
In-Reply-To: <20021015223319.GD41906@compsoc.man.ac.uk>
Message-ID: <m33cr7l3ab.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon <levon@movementarian.org> writes:

> This patch provides a simple api to let oprofile hook into
> the NMI interrupt for the perfctr profiler.

I would suggest using a notifier list instead (include/linux/notifier.h) 
This would handle multiple users cleanly.

-Andi
