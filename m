Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbUL3Hg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbUL3Hg5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 02:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbUL3Hg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 02:36:57 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:28865 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261562AbUL3Hgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 02:36:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KhsrNa2xfnSC3Q/GkAgeo33YkIHslPvg/H+Lx+C8FmRaPGsIKZJ+pjPkiY6BnPnlKofee6ZidoS5+xUHY2wQHhnl6UzwF+N8gjKI//o3xzABLY9hA1lxUIge8t6T8i5dGlkwBvb9qqStavYUpy3uzMawWVvwmFfdlWK9vQ0kTrs=
Message-ID: <4d8e3fd304122923362d823e34@mail.gmail.com>
Date: Thu, 30 Dec 2004 08:36:42 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Trying out SCHED_BATCH
Cc: kernel@kolivas.org, solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
In-Reply-To: <20041229232028.055f8786.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <m3mzw262cu.fsf@rajsekar.pc> <41CD51E6.1070105@kolivas.org>
	 <04ef01c4ede2$ff4a7cc0$0e25fe0a@pysiak> <41D31373.1090801@kolivas.org>
	 <4d8e3fd304122914466b42c632@mail.gmail.com>
	 <41D33603.9060501@kolivas.org>
	 <4d8e3fd304122923127167067c@mail.gmail.com>
	 <20041229232028.055f8786.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2004 23:20:28 -0800, Andrew Morton <akpm@osdl.org> wrote:
> Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> >
> > Andrew,
> >  what's your plan for the staircase scheduler ?
> 
> I have none, frankly.  I haven't seen any complaints about the current
> scheduler.
> 
> If someone can identify bad behaviour in the current scheduler which
> staircase improves then please describe a tescase which the scheduler
> developers can use to reproduce the situation.
> 
> If, after that, we deem that the problem cannot be feasibly fixed within the
> context of the current scheduler and that the problem is sufficiently
> serious to justify wholesale replacement of the scheduler then sure,
> staircase is an option.

Your answer makes lot of sense.
I think Con can explain the pro and cons of the staircase scheduler.

Best,

-- 
Paolo
