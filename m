Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264527AbUEXUmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbUEXUmi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 16:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264688AbUEXUmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 16:42:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:40416 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264527AbUEXUme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 16:42:34 -0400
Date: Mon, 24 May 2004 13:42:33 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: errorpath in expand_stack() [2.6.7-rc1]
Message-ID: <20040524134233.M22989@build.pdx.osdl.net>
References: <20040524202852.GB28273@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040524202852.GB28273@MAIL.13thfloor.at>; from herbert@13thfloor.at on Mon, May 24, 2004 at 10:28:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Herbert Poetzl (herbert@13thfloor.at) wrote:
> 
> another question:
> 
> I'm not sure the vm_unacct_memory(grow) is 
> correct here, but if, shouldn't there be the
> same in the security_vm_enough_memory(grow)
> path?

Currently, this is done inside the call to security_vm_enough_memory.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
