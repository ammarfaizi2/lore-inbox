Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263928AbUEXWaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbUEXWaZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 18:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264723AbUEXWaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 18:30:25 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:33189 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263928AbUEXWaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 18:30:23 -0400
Date: Tue, 25 May 2004 00:30:22 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20040524223022.GA29595@MAIL.13thfloor.at>
Mail-Followup-To: "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>,
	linux-kernel@vger.kernel.org
References: <67B3A7DA6591BE439001F2736233351202B47E6E@xch-nw-28.nw.nos.boeing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67B3A7DA6591BE439001F2736233351202B47E6E@xch-nw-28.nw.nos.boeing.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 03:20:33PM -0700, Laughlin, Joseph V wrote:
> I've been tasked with modifying a 2.4 kernel so that a non-root user can
> do the following:
> 
> Dynamically change the priorities of processes (up and down)
> Lock processes in memory
> Can change process cpu affinity
> 
> Anyone got any ideas about how I could start doing this?  (I'm new to
> kernel development, btw.)

check the kernel capability system ...
(it's quite simple)

#define CAP_SYS_NICE         23
#define CAP_IPC_LOCK         14

cpu scheduler affinity isn't part of 2.4 AFAIK
so there is no easy way to 'control' it ...

HTH,
Herbert

> Thanks,
> 
> Joe Laughlin
> Phantom Works - Integrated Technology Development Labs 
> The Boeing Company
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
