Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266514AbSLDNfe>; Wed, 4 Dec 2002 08:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266528AbSLDNfe>; Wed, 4 Dec 2002 08:35:34 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:6299 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S266514AbSLDNfd>;
	Wed, 4 Dec 2002 08:35:33 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] deprecate use of bdflush()
References: <Pine.LNX.3.96.1021203091821.5578A-100000@gatekeeper.tmr.com>
	<1038935401.994.9.camel@phantasy> <3DED0076.55B970DD@yahoo.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 04 Dec 2002 02:12:46 +0100
In-Reply-To: <3DED0076.55B970DD@yahoo.com>
Message-ID: <m3of82fuy9.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Gortmaker <p_gortmaker@yahoo.com> writes:

> Yes, removal is not premature; long overdue if anything.  At the risk
> of overlapping Andries' job as official historian, I found this in my
> archive of cruft.  So it was almost 1996  :)

So why don't we print the warning with 2.4 as well?

intrepid:~/CVS$ rpm -qi bdflush
Name        : bdflush    Relocations: (not relocateable)
Version     : 1.5        Vendor: Red Hat, Inc.
Release     : 21         Build Date: Sun Jun 23 16:19:27 2002

And it's run by /etc/inittab.

I don't know if returning -EINVAL (= removing the call completely in 2.5)
isn't better, though - does it have any compatibility implications?
-- 
Krzysztof Halasa
Network Administrator
