Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262444AbTCIGoZ>; Sun, 9 Mar 2003 01:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262447AbTCIGoZ>; Sun, 9 Mar 2003 01:44:25 -0500
Received: from packet.digeo.com ([12.110.80.53]:37304 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262444AbTCIGoZ>;
	Sun, 9 Mar 2003 01:44:25 -0500
Date: Sat, 8 Mar 2003 22:55:22 -0800
From: Andrew Morton <akpm@digeo.com>
To: Jason Straight <jason@JeetKuneDoMaster.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.64bk3 no screen after Ok booting kernel
Message-Id: <20030308225522.4e7301ea.akpm@digeo.com>
In-Reply-To: <200303090144.11339.jason@JeetKuneDoMaster.net>
References: <200303090144.11339.jason@JeetKuneDoMaster.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Mar 2003 06:54:56.0714 (UTC) FILETIME=[CB7192A0:01C2E608]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Straight <jason@JeetKuneDoMaster.net> wrote:
>
> I get the usual loading kernel, uncompressing, booting.
> 
> After it tells me it's booting the kernel I see no more screen activity at 
> all, but it is finishing the boot process. It does leave that text on the 
> screen, but nothing more.
> 
> I don't have any odd type console like serial or paralell unless there's 
> something I mistakenly turned on.
> 

You need to enable "Support for console on virtual terminal",
aka CONFIG_VT_CONSOLE.

Maybe someone should fix that.
