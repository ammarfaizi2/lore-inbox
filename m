Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbTBENJ4>; Wed, 5 Feb 2003 08:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261205AbTBENJ4>; Wed, 5 Feb 2003 08:09:56 -0500
Received: from mail.ithnet.com ([217.64.64.8]:63497 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S261173AbTBENJz>;
	Wed, 5 Feb 2003 08:09:55 -0500
Date: Wed, 5 Feb 2003 14:19:17 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
Message-Id: <20030205141917.235ee5a9.skraw@ithnet.com>
In-Reply-To: <1044447738.685.113.camel@zion.wanadoo.fr>
References: <20030202161837.010bed14.skraw@ithnet.com>
	<3E3D4C08.2030300@pobox.com>
	<20030202185205.261a45ce.skraw@ithnet.com>
	<3E3D6367.9090907@pobox.com>
	<20030205104845.17a0553c.skraw@ithnet.com>
	<1044443761.685.44.camel@zion.wanadoo.fr>
	<20030205123951.54207275.skraw@ithnet.com>
	<1044447738.685.113.camel@zion.wanadoo.fr>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Feb 2003 13:22:19 +0100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > I have to give a short note on this one:
> > indeed is the system currently running with a single CPU, _but_ since it is a
> > dual-mb the kernel is already compiled for SMP. It is started with "nosmp"
> > option though. I wanted to mention this not knowing if it is important for the
> > codepath.
> 
> Shouldn be an issue. I suppose you don't use fancy stuff like preempt or
> IDE taskfile IO, right ?

No, not at all. Pure and simple filesystem-I/O (reiserfs).

-- 
Regards,
Stephan
