Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289272AbSBDXMD>; Mon, 4 Feb 2002 18:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289273AbSBDXLv>; Mon, 4 Feb 2002 18:11:51 -0500
Received: from mx2.elte.hu ([157.181.151.9]:28853 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289272AbSBDXLo>;
	Mon, 4 Feb 2002 18:11:44 -0500
Date: Tue, 5 Feb 2002 02:09:29 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -K2
In-Reply-To: <20020205000842.A10594@werewolf.able.es>
Message-ID: <Pine.LNX.4.33.0202050208460.20189-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Feb 2002, J.A. Magallon wrote:

> Perhaps a missing
>
>  EXPORT_SYMBOL(set_user_nice);
> +EXPORT_SYMBOL(task_nice);
>
> in ksyms.c ??

you are right, my fault. Will show up in the next patch.

	Ingo


