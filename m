Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261796AbTCNWIS>; Fri, 14 Mar 2003 17:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262062AbTCNWIS>; Fri, 14 Mar 2003 17:08:18 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:4114
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S261796AbTCNWIR>; Fri, 14 Mar 2003 17:08:17 -0500
Subject: Re: 2.5.64-mm6: oops in elv_remove_request
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <20030314180716.GZ791@suse.de>
References: <1047576167.1318.4.camel@ixodes.goop.org>
	 <20030313175454.GP836@suse.de> <1047578690.1322.17.camel@ixodes.goop.org>
	 <20030313190247.GQ836@suse.de> <1047633884.1147.3.camel@ixodes.goop.org>
	 <20030314104219.GA791@suse.de> <1047637870.1147.27.camel@ixodes.goop.org>
	 <20030314113732.GC791@suse.de> <1047664774.25536.47.camel@ixodes.goop.org>
	 <20030314180716.GZ791@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1047680345.1508.2.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 14 Mar 2003 14:19:05 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-14 at 10:07, Jens Axboe wrote:
> > Ejecting and reinserting the disc seems to restore things:
> 
> Really weird, I can't reproduce here at all. My drive gives the correct
> result no matter if it's empty or loaded. Results are repeatable, too.
> DMA or PIO, didn't matter.
> 
> > Notice the "version" and "response format" fields have changed.
> 
> Yeah, something is really screwed. Hmmm, let spend a bit of time with
> this problem...

I just double-checked, and everything behaves as expected with ide-scsi.

	J

