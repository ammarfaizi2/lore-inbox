Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbVAVEpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbVAVEpN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 23:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbVAVEpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 23:45:13 -0500
Received: from host.atlantavirtual.com ([209.239.35.47]:21965 "EHLO
	host.atlantavirtual.com") by vger.kernel.org with ESMTP
	id S262661AbVAVEpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 23:45:08 -0500
Subject: Re: Loopback mounting from a file with a partition table?
From: kernel <kernel@crazytrain.com>
Reply-To: kernel@crazytrain.com
To: linux-kernel@vger.kernel.org
In-Reply-To: <pan.2005.01.22.01.45.31.457367@dcs.nac.uci.edu>
References: <pan.2005.01.22.01.45.31.457367@dcs.nac.uci.edu>
Content-Type: text/plain
Message-Id: <1106368961.3832.9.camel@crazytrain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 21 Jan 2005 23:42:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-21 at 20:45, Dan Stromberg wrote:
> Has anyone tried loopback mounting individual partitions from within a
> file that contains a partition table?
> 

Yes, lots of folks.


> When I mount -o loop the file, I seem to get the first partition in the
> file, but I don't see anything in the man page for mount that indicates a
> way of getting any other partitions from a file with a partition table.
> 
> Any comments?

Sure, find the starting offset for the filesystem and pass that to mount
via the '-o offset=XXX' flag.


regards,

-fd

www.farmerdude.com




