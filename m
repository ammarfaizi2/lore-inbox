Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263458AbTDGOn3 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTDGOn3 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:43:29 -0400
Received: from angband.namesys.com ([212.16.7.85]:9867 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP id S263458AbTDGOn2 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 10:43:28 -0400
Date: Mon, 7 Apr 2003 18:54:57 +0400
From: Oleg Drokin <green@namesys.com>
To: Nicholas Wourms <dragon@gentoo.org>
Cc: Nikita Danilov <Nikita@Namesys.COM>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove kdevname() before someone starts using it again
Message-ID: <20030407185457.A21725@namesys.com>
References: <20030331162634.A14319@lst.de> <3E908DF6.1050004@gentoo.org> <16017.11269.576246.373826@laputa.namesys.com> <3E91867A.1040504@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E91867A.1040504@gentoo.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Apr 07, 2003 at 10:08:58AM -0400, Nicholas Wourms wrote:
> > > A quick grep shows that Intermezzo FS still uses kdevname if 
> > > you've turned on debugging (fs/intermezzo/sysctl.c).  As for 
> > > pending stuff, both Reiser4 & pktcdvd also use it.  So I 
> >reiser4 switched to bdevname().
> When will the reiser4 bk repo be updated to reflect this? 
> It has been pretty quiet for the last few days or so, 
> compared to the daily updating it used to get.  As of 
> yesterday, trying to compile reiser4 as a module yeilded the 
> undefined reference to kdevname in a few places, not to 
> mention a few other undefined references as well...

Ah, our private bk repo -> public bk repo have died for some reason.
I restarted it. All the recent changes should appear soon.

Bye,
    Oleg
