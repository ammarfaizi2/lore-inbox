Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVANDRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVANDRS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVANDQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:16:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:50354 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261871AbVANDNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 22:13:23 -0500
Date: Thu, 13 Jan 2005 19:12:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: nickpiggin@yahoo.com.au, lkml@s2y4n2c.de, rlrevell@joe-job.com,
       arjanv@redhat.com, joq@io.com, chrisw@osdl.org, mpm@selenic.com,
       hch@infradead.org, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-Id: <20050113191237.25b3962a.akpm@osdl.org>
In-Reply-To: <200501140240.j0E2esKG026962@localhost.localdomain>
References: <1105669451.5402.38.camel@npiggin-nld.site>
	<200501140240.j0E2esKG026962@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Davis <paul@linuxaudiosystems.com> wrote:
>
> >SCHED_FIFO and SCHED_RR are definitely privileged operations and you
> 
> this is the crux of what this whole debate is about. for all of you
> people who think about linux on multi-user systems with network
> connectivity, running servers and so forth, this is clearly a given.
> 
> but there is large and growing body of machines that run linux where
> the sole human user of the machine has a strong and overwhelming
> desire to have tasks run with the characteristics offered by
> SCHED_FIFO and/or SCHED_RR. are they still "privileged" operations on
> this class of linux system? what about linux installed on an embedded
> system, with a small LCD screen and the sole purpose of running audio
> apps live? are they still privileged then?
> 

Paul.  Everyone agrees with you.  I think.  We just need to work out
the best way of doing it.

Would I be right in suspecting that we know what to do, but nobody has
stepped up to write the code?  It's kinda looking like that?
