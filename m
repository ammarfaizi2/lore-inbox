Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbTLWQiQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTLWQiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:38:16 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:63889 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262130AbTLWQiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:38:12 -0500
Date: Tue, 23 Dec 2003 17:38:10 +0100
From: Jens Axboe <axboe@suse.de>
To: Bart Samwel <bart@samwel.tk>, linux-kernel@vger.kernel.org
Subject: Re: Attempt at laptop-mode for 2.6.0
Message-ID: <20031223163810.GB23184@suse.de>
References: <3FE85E11.5020602@samwel.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE85E11.5020602@samwel.tk>
X-OS: Linux 2.4.23aa1-axboe i686
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23 2003, Bart Samwel wrote:
> Hi guys,
> 
> Even though I don't own a laptop, I find it very irritating that my hard
> drive is active so much. Wanting to fix this, I found the Jens Axboe's
> "laptop-mode" patch. Unfortunately it hadn't been ported to Linux
> 2.6.0 yet, and I'm using that as my primary kernel now. I gave porting 
> it a shot, and here is the result. I'm running it right now, and my hard 
> drive has been spun down for the complete time I have been writing this 
> message. Still, I'm not sure whether it really works as advertised. :) 
> The reason is that my PC is also a mail server for my personal e-mail, 
> and I receive e-mails more than once every 10 minutes (fscking spam!). 
> Still, the tests that I've done seem to indicate that it works.

Thanks for getting this started. I'm not particularly fond of the
behaviourial changes you made, I guess most are due to it being
incomplete?

The block dirtying is the most interesting aspect of the dump
functionality, reporting WRITEs don't give you the info you need
to fix your setup.

Jens

