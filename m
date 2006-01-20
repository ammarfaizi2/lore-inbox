Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWATRLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWATRLq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWATRLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:11:46 -0500
Received: from uproxy.gmail.com ([66.249.92.201]:580 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750901AbWATRLp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:11:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=JtLRWD21AeaiMQskHUooW8s3O46qMXzb441lXq1m8lcnTJ1PjQRNQj2sCicMx9cB0SXoxxkmb5VUsd2zT/qBEps1ihh5AamcHRU+IgNRjJrDPiVrB/WbBlv0EXwD7JoenPw+hSVFFuF5BsTjNTBiYvOwMbbX6UTQ6S0z6xlnxTg=
Date: Fri, 20 Jan 2006 18:11:24 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Michael Loftis <mloftis@wgops.com>
Cc: James@superbug.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-Id: <20060120181124.847b44bc.diegocg@gmail.com>
In-Reply-To: <6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
	<43D10FF8.8090805@superbug.co.uk>
	<6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 20 Jan 2006 09:36:35 -0700,
Michael Loftis <mloftis@wgops.com> escribió:


> That's the nail on the head exactly.  Why is this being done in an even 
> numbered kernel?  This represents an API change that has knock on well 
> outside of the kernel, and should be done in development releases.  Why is 
> it LK is the only major project (that I know of) that does this?  This is 
> akin to apache changing the format of httpd.conf and saying in say 1.3.38 
> and saying 'well we made the userland tools too.'

There's a Documentation/feature-removal-schedule.txt file. Is not that devfs
and other features were removed suddenly from one day to another. If external
developers don't care about maintaining code in (say) a 6 month timeframe
kernel developers can't do nothing. External developers are encouraged to
merge their code in the main tree anyway.

It's strange that you mention the devfs case. People wanted to remove 
devfs one or maybe two years ago, and Linus and/or akpm decided to kept
it to give people time to migrate. 

Please see the archives to understand why the people who maintains the
kernel and gets their ass kicked when a stable released has a bug decided 
to set up this development model.
