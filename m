Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVECUTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVECUTZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 16:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVECUTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 16:19:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:33170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261677AbVECUTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 16:19:19 -0400
Date: Tue, 3 May 2005 13:16:05 -0700
From: cliff white <cliffw@osdl.org>
To: Mauricio Lin <mauriciolin@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm2: fs/proc/task_mmu.c warnings
Message-ID: <20050503131605.655863db@es175>
In-Reply-To: <3f250c71050502165655f12110@mail.gmail.com>
References: <20050430164303.6538f47c.akpm@osdl.org>
	<20050501222916.GB3592@stusta.de>
	<3f250c7105050215306de620ac@mail.gmail.com>
	<3f250c7105050216357ae31105@mail.gmail.com>
	<20050502164501.50187481.akpm@osdl.org>
	<3f250c71050502165655f12110@mail.gmail.com>
Organization: OSDL
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2005 19:56:51 -0400
Mauricio Lin <mauriciolin@gmail.com> wrote:

> Hi Andrew,
> 
> On 5/2/05, Andrew Morton <akpm@osdl.org> wrote:
> > Mauricio Lin <mauriciolin@gmail.com> wrote:
> > >
> > > I managed to replicate the warning. This happens with the vanilla
> > > kernel 2.6.11.8. Before this version this warning does not exist. The
> > > last patch I posted was based on 2.6.11.7. I am going to post the new
> > > patch asap.
> > 
> > Please don't generate patches for the mainline kernel against the -stable
> > tree.  2.6.11.7 is ancient - we've added 22MB of diff since then.
> > 
> > I think I've fixed all the /proc/pid/smaps problems anwyay.
> 
> So you have fixed the warning message, right?
> 
> Do you mean that I do not have to create the patch for 2.6.11.8?

as i reported elsewhere in the thread, i still see the error on 2.6.12-rc3-mm2.
If you have a patch, i'd love to test it.
cliffw

> 
> BR,
> 
> Mauricio Lin.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
"Ive always gone through periods where I bolt upright at four in the morning; 
now at least theres a reason." -Michael Feldman
