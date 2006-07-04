Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWGDVAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWGDVAg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 17:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWGDVAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 17:00:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62480 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932275AbWGDVAf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 17:00:35 -0400
Date: Tue, 4 Jul 2006 18:30:43 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Fabio Comolli <fabio.comolli@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, mingo@redhat.com,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.17-mm5: lockdep prevents suspend to disk
Message-ID: <20060704183043.GA4420@ucw.cz>
References: <b637ec0b0607041258j36007132kdb7dbca1fa8f7dd5@mail.gmail.com> <20060704202115.GA16842@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704202115.GA16842@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > * 2.6.17-mm5 (plus hotfix)  suspends/resume to disk correctly
> > * adding lockdep testsuite breaks it
> > 
> > Extract from dmesg:
> 
> seems to be caused by:
> 
> > ACPI Error (exmutex-0283): Cannot release Mutex [BATM],
> > incorrect SyncLevel [20060623]
> 
> ?

No, I don't think so.

-- 
Thanks for all the (sleeping) penguins.
