Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbTJITks (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 15:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbTJITks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 15:40:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:40835 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262433AbTJITkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 15:40:43 -0400
Date: Thu, 9 Oct 2003 12:36:10 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@localhost.localdomain
To: Narayan Desai <desai@mcs.anl.gov>
cc: linux-kernel@vger.kernel.org
Subject: Re: pmdisk performance problem
In-Reply-To: <87fzi2jj41.fsf@mcs.anl.gov>
Message-ID: <Pine.LNX.4.44.0310091235340.985-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   Pat> Do you know if this was just for the write operation, or also
>   Pat> included stopping all processes?
> 
> This was during the write of ~4600 pages to disk.

Hm, that's definitely bad. 

>   Pat> Could you increase the log-level before you suspend and let me
>   Pat> know -- by looking at the debug messages -- what seems to take
>   Pat> the most time?
> 
> sorry, but how do i do this?

Sorry, 

	dmesg -n 8 

should do it.


	Pat

