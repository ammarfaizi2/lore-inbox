Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271281AbTHHHGR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 03:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271283AbTHHHGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 03:06:17 -0400
Received: from [66.212.224.118] ([66.212.224.118]:1811 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271281AbTHHHGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 03:06:14 -0400
Date: Fri, 8 Aug 2003 02:54:27 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
Cc: Paul.Russell@rustcorp.com.au, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG in fs/proc/generic.c:proc_file_read
In-Reply-To: <Pine.LNX.4.53.0308080252260.30770@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.53.0308080253460.30770@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0308072346020.3811-100000@localhost.localdomain>
 <Pine.LNX.4.53.0308080252260.30770@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Aug 2003, Zwane Mwaikambo wrote:

> On Thu, 7 Aug 2003, Nagendra Singh Tomar wrote:
> 
> > In short:
> > The hack used to be able to read proc files larger than 4k, breaks if the 
> > caller does lseek() after read()
> > 
> > My Question is. Is it a known problem ? 
> 
> Yep known issue, i need to get around to look and test the patch.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=952

Sorry ignore that, i should get some sleep.

-- 
function.linuxpower.ca
