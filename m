Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVAGViV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVAGViV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 16:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVAGVgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:36:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:50315 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261617AbVAGV30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:29:26 -0500
Date: Fri, 7 Jan 2005 13:29:18 -0800
From: Chris Wright <chrisw@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Lee Revell <rlrevell@joe-job.com>, "Jack O'Quin" <joq@io.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andreas Steinmetz <ast@domdv.de>,
       Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LAD mailing list <linux-audio-dev@music.columbia.edu>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107132918.I2357@build.pdx.osdl.net>
References: <1104865034.8346.4.camel@krustophenia.net> <41DB4476.8080400@domdv.de> <1104898693.24187.162.camel@localhost.localdomain> <20050107011820.GC2995@waste.org> <87brc17pj6.fsf@sulphur.joq.us> <20050107200245.GW2940@waste.org> <87mzvl56j5.fsf@sulphur.joq.us> <20050107204650.GY2940@waste.org> <1105131313.20278.81.camel@krustophenia.net> <20050107212018.GZ2940@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050107212018.GZ2940@waste.org>; from mpm@selenic.com on Fri, Jan 07, 2005 at 01:20:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matt Mackall (mpm@selenic.com) wrote:
> Feh. The RT scheduling class issue is orthogonal. Addressing mlock and
> scheduling class at once (and nothing else) is actually an ugliness of
> your LSM approach as there are folks who want mlock and not RT.

Last I checked they could be controlled separately in that module.  It
has been suggested (by me and others) that one possible solution would
be to expand it to be generic for all caps.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
