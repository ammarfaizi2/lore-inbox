Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVECWMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVECWMd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 18:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVECWMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 18:12:33 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:41480 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261850AbVECWMX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 18:12:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ENdak39y3lorzP2LNOXaJWF/K7jSVcd2Ewc2iZ99ioAAPWjzwtp70KAs+tE/LxvCyAKEz956eKoCrFcxxfJQtOOAW04bOAvZy9yKMQh6uzyVJHbzQL+hb07YddQfzLHe77A6zJmvdyvKAtibi6Frtc51WUZLxBvNgA2FsaaJapA=
Message-ID: <3f250c71050503151272cc8a3a@mail.gmail.com>
Date: Tue, 3 May 2005 18:12:22 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: cliff white <cliffw@osdl.org>
Subject: Re: 2.6.12-rc3-mm2: fs/proc/task_mmu.c warnings
Cc: Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050503131605.655863db@es175>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050430164303.6538f47c.akpm@osdl.org>
	 <20050501222916.GB3592@stusta.de>
	 <3f250c7105050215306de620ac@mail.gmail.com>
	 <3f250c7105050216357ae31105@mail.gmail.com>
	 <20050502164501.50187481.akpm@osdl.org>
	 <3f250c71050502165655f12110@mail.gmail.com>
	 <20050503131605.655863db@es175>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cliff,

On 5/3/05, cliff white <cliffw@osdl.org> wrote:
> On Mon, 2 May 2005 19:56:51 -0400
> Mauricio Lin <mauriciolin@gmail.com> wrote:
> 
> > Hi Andrew,
> >
> > On 5/2/05, Andrew Morton <akpm@osdl.org> wrote:
> > > Mauricio Lin <mauriciolin@gmail.com> wrote:
> > > >
> > > > I managed to replicate the warning. This happens with the vanilla
> > > > kernel 2.6.11.8. Before this version this warning does not exist. The
> > > > last patch I posted was based on 2.6.11.7. I am going to post the new
> > > > patch asap.
> > >
> > > Please don't generate patches for the mainline kernel against the -stable
> > > tree.  2.6.11.7 is ancient - we've added 22MB of diff since then.
> > >
> > > I think I've fixed all the /proc/pid/smaps problems anwyay.
> >
> > So you have fixed the warning message, right?
> >
> > Do you mean that I do not have to create the patch for 2.6.11.8?
> 
> as i reported elsewhere in the thread, i still see the error on 2.6.12-rc3-mm2.
> If you have a patch, i'd love to test it.

Andrew is fixing a lot of things. We should wait for the next -mm.

Am I right Andrew?

BR,

Mauricio Lin.

> cliffw
> 
> >
> > BR,
> >
> > Mauricio Lin.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> --
> "Ive always gone through periods where I bolt upright at four in the morning;
> now at least theres a reason." -Michael Feldman
>
