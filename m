Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264970AbUD2VjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264970AbUD2VjW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264870AbUD2Vha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:37:30 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:21782 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264978AbUD2Vga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:36:30 -0400
Date: Thu, 29 Apr 2004 14:34:03 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: vonbrand@inf.utfsm.cl, nickpiggin@yahoo.com.au, jgarzik@pobox.com,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040429143403.35a7a550.pj@sgi.com>
In-Reply-To: <20040429141947.1ff81104.akpm@osdl.org>
References: <40904A84.2030307@yahoo.com.au>
	<200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
	<20040429133613.791f9f9b.pj@sgi.com>
	<20040429141947.1ff81104.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Two things:
> a) a knob to say "only reclaim pagecache".  We have that now.
> b) a knob to say "reclaim vfs caches harder" ...

Are these knobs system wide in affect, or per job?
I am presuming system wide.

When I'm working late, I want my updatedb/backup jobs
to scrunch themselves into a corner, even as my builds
and gui desktop continue to fly and suck up RAM.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
