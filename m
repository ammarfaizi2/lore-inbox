Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263309AbUEaKta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbUEaKta (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 06:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbUEaKt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 06:49:29 -0400
Received: from uni02du.unity.ncsu.edu ([152.1.13.102]:3456 "EHLO
	uni02du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S263309AbUEaKt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 06:49:28 -0400
From: jlnance@unity.ncsu.edu
Date: Mon, 31 May 2004 06:49:28 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Message-ID: <20040531104928.GA1465@ncsu.edu>
References: <200405290037.17775.vda@port.imtp.ilyichevsk.odessa.ua> <E1BTpqM-0005LZ-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BTpqM-0005LZ-00@calista.eckenfels.6bone.ka-ip.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > cp should use fadvise() and say that it _really_ does not need those pages.
> 
> Yes, indeed. On the other hand the sequential read could be detected by the kernel, too.

I'm not sure.  Copying a file is a pretty good indication that you
are about to do something with either the new or the old file.

Thanks,

Jim
