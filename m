Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVANDgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVANDgl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVANDeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:34:20 -0500
Received: from moutng.kundenserver.de ([212.227.126.176]:41961 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261905AbVAND3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 22:29:22 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: utz lehmann <lkml@s2y4n2c.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com, arjanv@redhat.com,
       joq@io.com, chrisw@osdl.org, paul@linuxaudiosystems.com,
       mpm@selenic.com, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050113192028.248b39ed.akpm@osdl.org>
References: <20050111214152.GA17943@devserv.devel.redhat.com>
	 <200501112251.j0BMp9iZ006964@localhost.localdomain>
	 <20050111150556.S10567@build.pdx.osdl.net> <87y8ezzake.fsf@sulphur.joq.us>
	 <20050112074906.GB5735@devserv.devel.redhat.com>
	 <87oefuma3c.fsf@sulphur.joq.us>
	 <20050113072802.GB13195@devserv.devel.redhat.com>
	 <878y6x9h2d.fsf@sulphur.joq.us>
	 <20050113210750.GA22208@devserv.devel.redhat.com>
	 <1105651508.3457.31.camel@krustophenia.net>
	 <1105668319.15692.16.camel@segv.aura.of.mankind>
	 <41E729A9.7060005@kolivas.org>
	 <1105670137.15692.36.camel@segv.aura.of.mankind> <41E7319A.202@kolivas.org>
	 <20050113192028.248b39ed.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 04:28:38 +0100
Message-Id: <1105673318.15692.43.camel@segv.aura.of.mankind>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a3828f1c4d839cf12e8a3b808f7ed34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 19:20 -0800, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> >
> >  > btw: Are RT tasks excluded by the oom killer?
> > 
> >  I haven't looked. VM hackers?
> 
> Nope.  We're nastier to tasks which have been niced down, but we're not
> nicer to tasks which have been given elevated priority/policy.

Maybe this should be done?
RT tasks are somewhat important i think.


