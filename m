Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVAOBDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVAOBDS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVAOA7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:59:51 -0500
Received: from waste.org ([216.27.176.166]:33762 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262079AbVAOA7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:59:30 -0500
Date: Fri, 14 Jan 2005 16:58:49 -0800
From: Matt Mackall <mpm@selenic.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       nickpiggin@yahoo.com.au, lkml@s2y4n2c.de, rlrevell@joe-job.com,
       arjanv@redhat.com, joq@io.com, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       kernel@kolivas.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050115005849.GF3823@waste.org>
References: <1105669451.5402.38.camel@npiggin-nld.site> <200501140240.j0E2esKG026962@localhost.localdomain> <20050113191237.25b3962a.akpm@osdl.org> <20050114065701.GG2940@waste.org> <20050114121021.O24171@build.pdx.osdl.net> <20050114205512.GD3823@waste.org> <20050114150418.S24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114150418.S24171@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 03:04:18PM -0800, Chris Wright wrote:
> > Perhaps we want another helper function to do the rlim and
> > CAP_SYS_NICE check together.
> 
> Sure.
> -chris

This last version looks good to me. My only concern right now is
increasing the list of rlimits, but I can probably save those for the
next rlimit addition.

-- 
Mathematics is the supreme nostalgia of our time.
