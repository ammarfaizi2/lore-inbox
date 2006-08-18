Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161086AbWHRTDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbWHRTDs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 15:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbWHRTDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 15:03:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:10388 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161082AbWHRTDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 15:03:47 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: + support-piping-into-commands-in-proc-sys-kernel-core_pattern.patch added to -mm tree
Date: Fri, 18 Aug 2006 22:11:54 +0200
User-Agent: KMail/1.9.1
Cc: Thierry Vignaud <tvignaud@mandriva.com>, linux-kernel@vger.kernel.org
References: <200608161809.k7GI9ODk007199@shell0.pdx.osdl.net> <m2fyftevt0.fsf@vador.mandriva.com> <20060818114835.bcdac825.akpm@osdl.org>
In-Reply-To: <20060818114835.bcdac825.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608182211.55727.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >
> > nice but what if the core analyzer segfaults too? looping? DOS
> > coredumping :-) ?
>
> rofl.  Good question ;)

It can happen in a couple of situations anyways. But I guess we can
just force ulimit -c to zero before running the pipe process.

-Andi
