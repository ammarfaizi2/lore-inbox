Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVA1CiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVA1CiV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 21:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVA1CiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 21:38:21 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:40886 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261403AbVA1CiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 21:38:15 -0500
Subject: Re: [Bug 4081] New: OpenOffice crashes while starting due to a  
	threading error
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Martin Josefsson <gandalf@wlug.westbo.se>, linux-kernel@vger.kernel.org
In-Reply-To: <41F97E07.2040709@comcast.net>
References: <217740000.1106412985@[10.10.2.4]>	<41F30E0A.9000100@osdl.org>
	 <1106482954.1256.2.camel@tux.rsn.bth.se>
	 <20050126132504.3295e07d@dxpl.pdx.osdl.net>  <41F97E07.2040709@comcast.net>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 19:38:11 -0700
Message-Id: <1106879891.3667.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.4 (2.1.4-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't look at the trace. My only problem is in saving new files. I
can copy an old one, rename it and start, empty it and save fine. I just
can't save new ones.

Anyway, I hope this gets fixed. I am running pure rawhide Fedora Core,
just so you know... latest of everything.

Trever

On Thu, 2005-01-27 at 18:49 -0500, Parag Warudkar wrote:
>  From strace output which Trever sent, OO.o seems to be getting many 
> -EINTRs (Interrupted System Call) which are attempted to be restarted 
> but again recieve EINTR when restarted. (futex, accept and poll are the 
> ones which get EINTR).
> 
> Whereas, when OO.o successfully starts up on my machine, I get no EINTRs 
> at all.
> 
> Stephen - Is it possible for you to post strace from your machine ? If 
> you see the same symptoms we can look at what changed in that area.
> 
> Thanks
> Parag
> 
> Stephen Hemminger wrote:
> 
> >On my laptop with Fedora Core 3, OpenOffice 1.0.1, 1.0.4 and the pre 2.0 version
> >all work fine running 2.6.10-FCxx kernel but get a SEGV when running on 2.6.11-rc1 or 2.6.11-rc2
> >
> >Any hints?
> >
> >
> >  
> >
> 
> 
--
"There are two races of people - men and women - no matter what women's
libbers would have you pretend. The male is motivated by toys and
science because men are born with no purpose in the universe except to
procreate. there is lots of time to kill beyond that...Women, however,
are born with a center. They can create the universe, mother it, teach
it, nurture it. Men read science fiction to build the future. Women
don't need to read it. They are the future." -- Ray Bradbury

