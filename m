Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbUATWAU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 17:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265814AbUATWAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 17:00:20 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:1292 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265808AbUATWAP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 17:00:15 -0500
Date: Tue, 20 Jan 2004 23:12:23 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: GCS <gcs@lsc.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm5 dies booting, possibly network related
Message-ID: <20040120221223.GA9593@hh.idb.hist.no>
References: <20040120000535.7fb8e683.akpm@osdl.org> <400D083F.6080907@aitel.hist.no> <20040120175408.GA12805@lsc.hu> <20040120102302.47fa26cd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120102302.47fa26cd.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 10:23:02AM -0800, Andrew Morton wrote:
> GCS <gcs@lsc.hu> wrote:
> >
> > Offtopic ps:Sorry that I can not help further now, I kicked a door too
> >  badly that I think I broke my little finger on my leg. :-( But it would
> >  worth to try without CONFIG_REGPARM as Helge noted he has it turned on,
> >  and at least I also have it as Y.
> 
> CONFIG_REGPARM doesn't work on gcc-2.95 (at least), due to apparent
> miscompilation or misdesign of strstr().  There are probably other such
> issues.
> 
This was gcc 3.3.2 (from debian testing)
It has a bug that's fixed by compiling with frame pointer.  It didn't help
this though.

> So yes, whatever compiler you are using, turn off CONFIG_REGPARM - it is
> still very experimental.
> 
I'll try.

Helge Hafting
