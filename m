Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbTHSJFp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 05:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267402AbTHSJFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 05:05:45 -0400
Received: from aneto.able.es ([212.97.163.22]:58601 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S267186AbTHSJFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 05:05:43 -0400
Date: Tue, 19 Aug 2003 11:05:41 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@osdl.org>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, russo.lutions@verizon.net,
       linux-kernel@vger.kernel.org
Subject: Re: cache limit
Message-ID: <20030819090541.GA9038@werewolf.able.es>
References: <3F41AA15.1020802@verizon.net> <200308190533.h7J5XoL06419@Port.imtp.ilyichevsk.odessa.ua> <20030818232024.20c16d1f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030818232024.20c16d1f.akpm@osdl.org>; from akpm@osdl.org on Tue, Aug 19, 2003 at 08:20:24 +0200
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.19, Andrew Morton wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> >
> > There was a discussion (and patches) in the middle of 2.5 series
> >  about O_STREAMING open flag which mean "do not aggressively cache
> >  this file". Targeted at MP3/video playing, copying large files and such.
> > 
> >  I don't know whether it actually was merged. If it was,
> >  your program can use it.
> 
> It was not.  Instead we have fadvise.  So it would be appropriate to change

Does this work in 2.4 ?
If not, any patch flying around ?
It would be interesting to have this functionality in 2.4 also so
people can start modifying and teting things like DVD readers, rsync,
updatedb, grep and so on...

I have tested O_STREAMING in 2.4 and it is fine...

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-rc2-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
