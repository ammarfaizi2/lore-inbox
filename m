Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbTIZQLG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 12:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbTIZQLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 12:11:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:30114 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261347AbTIZQLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 12:11:05 -0400
Date: Fri, 26 Sep 2003 09:10:46 -0700
From: Chris Wright <chrisw@osdl.org>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Syscall security
Message-ID: <20030926091046.A24375@osdlab.pdx.osdl.net>
References: <Pine.LNX.4.44.0309261553180.6080-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0309261553180.6080-100000@gaia.cela.pl>; from maze@cela.pl on Fri, Sep 26, 2003 at 04:05:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Maciej Zenczykowski (maze@cela.pl) wrote:
> I'm wondering if there is any way to provide per process bitmasks of 
> available/illegal syscalls.  Obviously this should most likely be 
> inherited through exec/fork.

A simple LSM module can do this for you.  It will have a little
more overhead than denying at the syscall entry point, but it's
certainly going to be more flexible.

-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
