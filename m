Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWGHGjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWGHGjQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 02:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWGHGjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 02:39:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7236 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750784AbWGHGjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 02:39:15 -0400
Date: Sat, 8 Jul 2006 08:41:32 +0200
From: Jens Axboe <axboe@suse.de>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Andrew Morton <akpm@osdl.org>, Michael Kerrisk <mtk-manpages@gmx.net>,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net,
       vendor-sec@lst.de
Subject: Re: splice/tee bugs?
Message-ID: <20060708064131.GG4188@suse.de>
References: <20060707070703.165520@gmx.net> <20060707040749.97f8c1fc.akpm@osdl.org> <20060707131310.0e382585@doriath.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707131310.0e382585@doriath.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07 2006, Luiz Fernando N. Capitulino wrote:
> On Fri, 7 Jul 2006 04:07:49 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> | On Fri, 07 Jul 2006 09:07:03 +0200
> | "Michael Kerrisk" <mtk-manpages@gmx.net> wrote:
> | 
> | > c) Occasionally the command line just hangs, producing no output.
> | >    In this case I can't kill it with ^C or ^\.  This is a 
> | >    hard-to-reproduce behaviour on my (x86) system, but I have 
> | >    seen it several times by now.
> | 
> | aka local DoS.  Please capture sysrq-T output next time.
> 
>  If I run lots of them in parallel, I get the following OOPs in a few
> seconds:

With the patch posted? You need the i vs nrbufs fix.

-- 
Jens Axboe

