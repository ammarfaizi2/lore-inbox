Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263254AbTIWXYQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 19:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbTIWXYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 19:24:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:10633 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263254AbTIWXYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 19:24:15 -0400
Date: Tue, 23 Sep 2003 16:24:10 -0700
From: Chris Wright <chrisw@osdl.org>
To: Bruno Castro da Silva <sysware@portoweb.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: syscall hook
Message-ID: <20030923162410.B15254@osdlab.pdx.osdl.net>
References: <3f70d6f9.cec.16345@portoweb.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3f70d6f9.cec.16345@portoweb.com.br>; from sysware@portoweb.com.br on Tue, Sep 23, 2003 at 08:27:53PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bruno Castro da Silva (sysware@portoweb.com.br) wrote:
> I need to put a hook on a syscall so I can monitor the usage
> of sockets. I'm trying to do so without having to recompile
> the kernel (eg by using modules). Can anyone give me a hint
> on how to achieve this?

You can't (and don't want to) hook syscalls in any current kernels.  Check
out the socket level hooks in the LSM framework.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
