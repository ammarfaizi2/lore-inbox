Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263255AbTIAT5J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 15:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTIAT5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 15:57:09 -0400
Received: from smtp02.fuse.net ([216.68.1.133]:435 "EHLO smtp02.fuse.net")
	by vger.kernel.org with ESMTP id S263255AbTIAT5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 15:57:07 -0400
From: "Dale E Martin" <dmartin@cliftonlabs.com>
Date: Mon, 1 Sep 2003 15:57:06 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: repeatable, hard lockup on boot in linux-2.6.0-test4 (more details)
Message-ID: <20030901195706.GA853@cliftonlabs.com>
References: <20030901182359.GA871@cliftonlabs.com> <20030901120412.2047eeff.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901120412.2047eeff.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you able to plug any PS/2 devices into the machine, see if that makes
> a difference?

Yes, plugging in a PS/2 mouse in addition to the USB mouse does allow the
machine to boot up.  (Just tried it, thanks for the suggestion.)
 
> Also it would be useful to add the option "initcall_debug" to the kernel
> boot command line.  Then you will see a bunch of messages of the form
> 
> 	calling initcall 0xNNNNNNNN
> 
> Please look up the final address in the System.map file from the 2.6 build.
> This will give us an idea of what the machine was trying to do when it
> died.

It was in "i8042_init".  Thanks again for the help.

Take care,
     Dale
-- 
Dale E. Martin, Clifton Labs, Inc.
Senior Computer Engineer
dmartin@cliftonlabs.com
http://www.cliftonlabs.com
pgp key available
