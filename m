Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVANDZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVANDZD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVANDWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:22:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:47290 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261887AbVANDVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 22:21:34 -0500
Date: Thu, 13 Jan 2005 19:20:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: lkml@s2y4n2c.de, rlrevell@joe-job.com, arjanv@redhat.com, joq@io.com,
       chrisw@osdl.org, paul@linuxaudiosystems.com, mpm@selenic.com,
       hch@infradead.org, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-Id: <20050113192028.248b39ed.akpm@osdl.org>
In-Reply-To: <41E7319A.202@kolivas.org>
References: <20050111214152.GA17943@devserv.devel.redhat.com>
	<200501112251.j0BMp9iZ006964@localhost.localdomain>
	<20050111150556.S10567@build.pdx.osdl.net>
	<87y8ezzake.fsf@sulphur.joq.us>
	<20050112074906.GB5735@devserv.devel.redhat.com>
	<87oefuma3c.fsf@sulphur.joq.us>
	<20050113072802.GB13195@devserv.devel.redhat.com>
	<878y6x9h2d.fsf@sulphur.joq.us>
	<20050113210750.GA22208@devserv.devel.redhat.com>
	<1105651508.3457.31.camel@krustophenia.net>
	<1105668319.15692.16.camel@segv.aura.of.mankind>
	<41E729A9.7060005@kolivas.org>
	<1105670137.15692.36.camel@segv.aura.of.mankind>
	<41E7319A.202@kolivas.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
>  > btw: Are RT tasks excluded by the oom killer?
> 
>  I haven't looked. VM hackers?

Nope.  We're nastier to tasks which have been niced down, but we're not
nicer to tasks which have been given elevated priority/policy.
