Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262754AbUK0CLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbUK0CLw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbUK0CLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:11:31 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262754AbUKZThH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:37:07 -0500
Date: Thu, 25 Nov 2004 19:12:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Chandler <alan@chandlerfamily.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd problem
Message-ID: <20041125181249.GN12098@suse.de>
References: <20041122080122.GM26240@suse.de> <E1CWBSN-0003mF-4s@home.chandlerfamily.org.uk> <20041122105157.GB10463@suse.de> <E1CWCOC-0003so-Ao@home.chandlerfamily.org.uk> <20041122113150.GF10463@suse.de> <E1CWDhN-00040Y-E6@home.chandlerfamily.org.uk> <20041122130202.GO10463@suse.de> <1101338347.2571.8.camel@localhost.localdomain> <20041125152922.GC12098@suse.de> <1101399946.18177.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101399946.18177.25.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25 2004, Alan Cox wrote:
> On Iau, 2004-11-25 at 15:29, Jens Axboe wrote:
> > Something is funky with this drive, it requires an extra delay after it
> > has raised an interrupt. But we can restrict it to ide-cd once it's
> > fully understood.
> 
> You are assuming its a drive issue. Some controllers have errata around
> this area that might be involved too. We can certainly stick a quirk for
> IRQ delay into the drive tho

That's true - Alan (Chandler), can you provide an lspci of the system as
well?

-- 
Jens Axboe

