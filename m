Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVEaMQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVEaMQw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 08:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVEaMQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 08:16:52 -0400
Received: from darwin.snarc.org ([81.56.210.228]:33178 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S261881AbVEaMQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 08:16:49 -0400
Date: Tue, 31 May 2005 14:16:47 +0200
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: more thread_info patches
Message-ID: <20050531121647.GA17867@snarc.org>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <42676B76.4010903@ppp0.net> <Pine.LNX.4.62.0504211105550.13231@numbat.sonytel.be> <20050421161106.GY13052@parcelfarce.linux.theplanet.co.uk> <20050421173908.GZ13052@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.61.0505310113370.10977@scrub.home> <Pine.LNX.4.61.0505310136050.10977@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505310136050.10977@scrub.home>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.9i
From: tab@snarc.org (Vincent Hanquez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 01:51:09AM +0200, Roman Zippel wrote:
> Hi,

Hey Roman,

> Index: linux-2.6-mm/arch/alpha/kernel/ptrace.c
> ===================================================================
> ....
> -		addr = &task->thread_info->pcb.unique;
> +		addr = &task_thread_infotask)->pcb.unique;

you forget a left parenthesis here

cheers,
-- 
Vincent Hanquez
