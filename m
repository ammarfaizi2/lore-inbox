Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267321AbUGNIXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267321AbUGNIXk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 04:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267318AbUGNIXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 04:23:40 -0400
Received: from mail.zmailer.org ([62.78.96.67]:10682 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S267321AbUGNIXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 04:23:38 -0400
Date: Wed, 14 Jul 2004 11:23:36 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: Mail System Error - Returned Mail
Message-ID: <20040714082336.GM1486@mea-ext.zmailer.org>
References: <200407132306.39569.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407132306.39569.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 11:06:39PM -0400, Gene Heskett wrote:
> Greetings;
> 
> I'm getting a lot of these bounces, any good reason?

Dunno,  but we also see (every now and then) that Verizon
system rejects emails towards it with MAIL FROM giving
vger.kernel.org  domain.

Reading deeper, the visible "To:" header, and "remote mta"
line do say:   vgr.kernel.org   which isn't quite exactly right...

Perhaps you should ask from the given  <postmaster@verizon.net>
contact address for assistance ?  (And do send them the full
version, not just this abridged one.)

>From the symptoms I do suspect that Verizon's DNS server(s) are
malfunctioning somehow.

An alternate is that their MTA software is treating temporary DNS
failures (like lookup timeout) as instantly permanent failures and
as a valid reason for reject, which would be a mad thing to do.

I have seen even that to happen before, although mainly with SMTP-
receivers, that report 500-series codes even for DNS timeouts.
In that protocol there are also 400-series codes, that are supposed
to be used in these "I can't find out now, do retry LATTER."

/Matti Aarnio -- one of  <postmaster@vger.kernel.org>


> ----------  Forwarded Message  ----------
> 
> Subject: Mail System Error - Returned Mail
> Date: Tuesday 13 July 2004 13:34
> From: Mail Administrator <Postmaster@verizon.net>
> To: gene.heskett@verizon.net
> 
>      Host vger.kernel.org not found
> 
> The following recipients did not receive this message:
> 
>      <linux-kernel@vger.kernel.org>
> 
> Please reply to Postmaster@verizon.net
> if you feel this message to be in error.
> 
> -- 
> Cheers, Gene

> Status: 5.1.2
> Remote-MTA: dns; vgr.kernel.org

> From: Gene Heskett <gene.heskett@verizon.net>
> To: linux-kernel@vgr.kernel.org
> Subject: Re: SATA disk device naming ?
> Date: Tue, 13 Jul 2004 13:34:07 -0400
> Content-Type: text/plain;
>   charset="us-ascii"
