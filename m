Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264563AbTI2T1s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 15:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264564AbTI2T1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 15:27:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:22233 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264563AbTI2T1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 15:27:47 -0400
Date: Mon, 29 Sep 2003 12:27:09 -0700
From: Chris Wright <chrisw@osdl.org>
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6-mm1: too many defunct event threads
Message-ID: <20030929122709.B6895@osdlab.pdx.osdl.net>
References: <200309292115.57918.gallir@uib.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200309292115.57918.gallir@uib.es>; from gallir@uib.es on Mon, Sep 29, 2003 at 09:15:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ricardo Galli (gallir@uib.es) wrote:
> Just tested -mm1 in my laptop, with synaptics drivers, and saw lots of 
> zombi event threads.

Please revert the call_usermodehelper patch.

ftp:/ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6.0-test6-mm1/broken-out/call_usermodehelper-retval-fix-2.patch

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
