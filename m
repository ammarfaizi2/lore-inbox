Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTE3MEi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 08:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263594AbTE3MEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 08:04:38 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16778 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263591AbTE3MEi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 08:04:38 -0400
Date: Fri, 30 May 2003 14:17:02 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Morten Helgesen <morten.helgesen@nextframe.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: list_head debugging patch
In-Reply-To: <1054292079.23566.22.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.SOL.4.30.0305301403090.1217-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 30 May 2003, Alan Cox wrote:

> On Iau, 2003-05-29 at 22:09, William Lee Irwin III wrote:
> > On Thursday 29 May 2003 22:13, William Lee Irwin III wrote:
> > >> Same thing; nuke the __list_head_check() check in list_empty()
> > >> please.
> >
> > On Thu, May 29, 2003 at 11:03:19PM +0200, Morten Helgesen wrote:
> > > Ok, after having nuked __list_head_check() in list_empty() I can`t
> > > seem to trigger any more list corruption on this box.
> >
> > Well, that's a hopeful sign; at some point maybe IDE will stop oopsing
> > on me with it.
>
> The IDE code has real list mangling bugs at probe. They are fixed in -ac
> but I'm still waiting for the taskfile stuff to get sorted so I can do
> a sane merge of the stuff pending.

List mangling at probe is fixed in 2.5.69-ac1, but there are more bugs
with different triggerability.
--
Bartlomiej

