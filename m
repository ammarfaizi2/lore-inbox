Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUAQKZF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 05:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266010AbUAQKZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 05:25:05 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:54703 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S266003AbUAQKZA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 05:25:00 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: kgdb 2.0.4 with restructuring and fixes
Date: Sat, 17 Jan 2004 15:54:21 +0530
User-Agent: KMail/1.5
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>, Steve Gonczi <steve@relicore.com>,
       Matt Mackall <mpm@selenic.com>
References: <200401171451.38701.amitkale@emsyssoft.com> <20040117100127.GI1332@holomorphy.com>
In-Reply-To: <20040117100127.GI1332@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401171554.21553.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah...
I understand. I also don't like URLs in email as my browser and mailer are 
different.

I am really sorry, the best I can do is post a link to actuall tarball which 
is: http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.0.4.tar.bz2

I believe people will have me on their spammers list if I actually inflate 
this tarball and send as attachments. I sent 3 such postings this week!

On Saturday 17 Jan 2004 3:31 pm, William Lee Irwin III wrote:
> On Sat, Jan 17, 2004 at 02:51:38PM +0530, Amit S. Kale wrote:
> > kgdb 2.0.4 is available at http://kgdb.sourceforge.net ChangeLog below.
> > Thanks.
> > Amit Kale
> > EmSysSoft (http://www.emsyssoft.com)
> > KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)
> > 2004-01-17 Tom Rini <trini@kernel.crashing.org>
> > 	* Some restructuring to allow architectures to provide different
> > 	serial infos to the kgdb serial interface.
> > 2004-01-17 Pavel Machek <pavel@suse.cz>
> > 	* Cleanups
> > 	* changed calling convention from 0 on success, 1 on failure to 0 on
> > 	success, -ERRNO on fail to be more consistent with rest of kernel
> > 	* Made kgdb waiting for connection message KERN_CRIT
> > 	* export kern_schedule only if CONFIG_KGDB_THREAD is defined
>
> This sound great. Any chance you could splatter this out at a patch
> series to lkml for those of us so entrenched in pre-1994 conventions
> (such as myself) as to dislike chasing URL's from mailing list posts?
>
>
> -- wli

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

