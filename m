Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264983AbUD2VxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264983AbUD2VxH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264987AbUD2VxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:53:07 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:64826 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264983AbUD2Vvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:51:47 -0400
Date: Thu, 29 Apr 2004 14:47:37 -0700
From: Paul Jackson <pj@sgi.com>
To: Timothy Miller <miller@techsource.com>
Cc: vonbrand@inf.utfsm.cl, nickpiggin@yahoo.com.au, jgarzik@pobox.com,
       akpm@osdl.org, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040429144737.3b0c736b.pj@sgi.com>
In-Reply-To: <409175CF.9040608@techsource.com>
References: <40904A84.2030307@yahoo.com.au>
	<200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
	<20040429133613.791f9f9b.pj@sgi.com>
	<409175CF.9040608@techsource.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy wrote:
> Perhaps nice level could influence how much a process is allowed to 
> affect page cache.

I'm from the school that says 'nice' applies to scheduling priority,
not memory usage.

I'd expect a different knob, a per-task inherited value as is 'nice',
to control memory usage.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
