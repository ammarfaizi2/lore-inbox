Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269882AbRHEAwX>; Sat, 4 Aug 2001 20:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269883AbRHEAwE>; Sat, 4 Aug 2001 20:52:04 -0400
Received: from [209.250.53.120] ([209.250.53.120]:2578 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S269882AbRHEAvz>; Sat, 4 Aug 2001 20:51:55 -0400
Date: Sat, 4 Aug 2001 19:51:31 -0500
From: Steven Walter <srwalter@yahoo.com>
To: rich+ml@lclogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: module unresolved symbols
Message-ID: <20010804195131.A17350@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>, rich+ml@lclogic.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0108041726050.8186-100000@baddog.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0108041726050.8186-100000@baddog.localdomain>; from rich+ml@lclogic.com on Sat, Aug 04, 2001 at 05:39:17PM -0700
X-Uptime: 7:50pm  up 4 days, 22:24,  2 users,  load average: 1.00, 1.00, 1.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2001 at 05:39:17PM -0700, rich+ml@lclogic.com wrote:
> Hi all, kindly redirect me if this is the wrong list.
> 
> Starting with a stock RH 7.0 install, I changed a single kernel config
> item and recompiled with 'make defs clean bzImage modules
> modules_install'.
> 
> Booted on the new kernel and depmod complains that dozens of modules
> contain unresolved symbols. Back to the original kernel, now it also
> complains of unresolved symbols (not the same set of modules, and modules
> that were previously OK).
> 
> I can't find an answer on the net, does anyone know how to fix this?
> 
> Thanks == Rich

For one, it should have been 'make deps clean bzImage modules'.
However, depending on the option you changed, a 'make mrproper' may have
been in order.  Be sure to back up your .config first, though
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
