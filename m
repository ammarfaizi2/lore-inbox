Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263643AbTE0TBB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbTE0TBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:01:01 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:10907 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263643AbTE0TA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:00:58 -0400
Date: Tue, 27 May 2003 16:12:07 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.21-rc4] Fix oom killer braindamage
In-Reply-To: <200305272104.05802.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.55L.0305271611410.9487@freak.distro.conectiva>
References: <200305272104.05802.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 May 2003, Marc-Christian Petersen wrote:

> Hi Marcelo,
>
> attached patch fixes the oom killer braindamage where it tries to kill
> processes again and again and again w/o any ending or successfull killing of
> the selected processes in an OOM case.
>
> The attached, very simple but effective, patch fixes it.
>
> All the kudos go to Rik van Riel.
>
> Patch tested and works, and also for a long time in my tree (and maybe also
> others?!)
>
> This issue is out there for several years.
>
> Please consider it for 2.4.21-rc5, thanks.

Not suitable for -rc. Btw, -rc5 is already at bkbits.net.
