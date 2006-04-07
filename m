Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWDGJzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWDGJzN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 05:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWDGJzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 05:55:13 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:27021 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932406AbWDGJzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 05:55:11 -0400
Date: Fri, 7 Apr 2006 11:52:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, pwil3058@bigpond.net.au, kernel@kolivas.org
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Message-ID: <20060407095247.GA2788@elte.hu>
References: <1144402690.7857.31.camel@homer> <20060407024758.22417917.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407024758.22417917.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Mike Galbraith <efault@gmx.de> wrote:
> >
> > Problem:
> 
> I don't know what to do with all these patches you keep sending.
> 
> a) The other sched guys seem to be hiding and
> 
> b) I'm still sitting on smpnice, and I don't think that's had all its
>    problems ironed out yet, so putting the interactivity things in 
>    there as well will complicate getting that sorted out.

i think we should try Mike's patches after smpnice got ironed out. The 
extreme-starvation cases should be handled more or less correctly now by 
the minimal set of changes from Mike that are upstream (knock on wood), 
the singing-dancing add-ons can probably wait a bit and smpnice clearly 
has priority.

	Ingo
