Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbTJITZp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 15:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbTJITZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 15:25:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:22761 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262070AbTJITZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 15:25:44 -0400
Date: Thu, 9 Oct 2003 12:21:09 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@localhost.localdomain
To: Narayan Desai <desai@mcs.anl.gov>
cc: linux-kernel@vger.kernel.org
Subject: Re: pmdisk performance problem
In-Reply-To: <87k77ejkfp.fsf@mcs.anl.gov>
Message-ID: <Pine.LNX.4.44.0310091218210.985-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> When using 2.6.0-test7 on an ibm thinkpad t21, pmdisk works properly,
> though it takes quite a while to write out pages to disk. On my last
> suspend to disk, it took on the order of 8-10 minutes. After this
> completed, i was able to successfully resume, fairly speedily, however
> my hardware clock was 8-10 minutes behind. Does anyone have any ideas
> why this is happening? thanks...

Do you know if this was just for the write operation, or also included 
stopping all processes? 

Could you increase the log-level before you suspend and let me know -- by 
looking at the debug messages -- what seems to take the most time? 

Thanks,


	Pat

