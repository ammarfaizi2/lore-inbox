Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266417AbUAWJ2x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 04:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266457AbUAWJ2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 04:28:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:55510 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266417AbUAWJ2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 04:28:51 -0500
Date: Fri, 23 Jan 2004 01:29:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: vojtech@suse.cz, kieran@ihateaol.co.uk, linux-kernel@vger.kernel.org
Subject: Re: uk keyboard broken by input updates?
Message-Id: <20040123012927.6cddd754.akpm@osdl.org>
In-Reply-To: <1074848307.2358.1.camel@wyatt.hadess.net>
References: <1073901824.29420.14.camel@bnocera.surrey.redhat.com>
	<40027510.1080600@ihateaol.co.uk>
	<20040112103256.GA4038@ucw.cz>
	<1074848307.2358.1.camel@wyatt.hadess.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bastien Nocera <hadess@hadess.net> wrote:
>
> Hello Vojtech,
> 
> Is there any particular reason why this didn't make it into 2.6.2-rc1? I
> just checked the 2.6.1 to 2.6.2-rc1 patch, and the only change to
> char/keyboard.c seems to be a change in an #ifdef.
> 
> > -	 80, 81, 82, 83, 84, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
> > -	284,285,309,311,312, 91,327,328,329,331,333,335,336,337,338,339,
> > +	 80, 81, 82, 83, 43, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
> > +	284,285,309,298,312, 91,327,328,329,331,333,335,336,337,338,339,

These changes were merged post-2.6.2-rc1.  Please test 2.6.2-rc1-mm2 or the
latest bk snapshot.

