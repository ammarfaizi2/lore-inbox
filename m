Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136697AbREATJz>; Tue, 1 May 2001 15:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136698AbREATJq>; Tue, 1 May 2001 15:09:46 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:1541 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S136697AbREATJi>; Tue, 1 May 2001 15:09:38 -0400
Date: Tue, 1 May 2001 15:09:34 -0400 (EDT)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: Linux 2.4.4-ac2
In-Reply-To: <20010501205510.A1059@werewolf.able.es>
Message-ID: <Pine.LNX.4.10.10105011508440.17091-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	 * Make sure the child gets the SCHED_YIELD flag cleared, even if
> +	 * it inherited it, to avoid deadlocks.

can anyone think of a reason that SCHED_YIELD *should* be inherited?
I think it's just oversight that fork doesn't clear it.

