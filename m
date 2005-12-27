Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbVL0V44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVL0V44 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 16:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVL0V44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 16:56:56 -0500
Received: from mail.autoweb.net ([198.172.237.26]:31967 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S932370AbVL0V4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 16:56:55 -0500
Date: Tue, 27 Dec 2005 16:55:29 -0500
From: Ryan Anderson <ryan@michonline.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Jaco Kroon <jaco@kroon.co.za>, rlrevell@joe-job.com, jason@stdbev.com,
       rostedt@goodmis.org, linux-kernel@vger.kernel.org, pavel@ucw.cz,
       s0348365@sms.ed.ac.uk
Subject: Re: recommended mail clients
Message-ID: <20051227215529.GA31178@mythryan2.michonline.com>
References: <43AF7724.8090302@kroon.co.za> <43AFB005.50608@kroon.co.za> <1135607906.5774.23.camel@localhost.localdomain> <200512261535.09307.s0348365@sms.ed.ac.uk> <1135619641.8293.50.camel@mindpipe> <0f197de4ee389204cc946086d1a04b54@stdbev.com> <1135621183.8293.64.camel@mindpipe> <43B03658.9040108@kroon.co.za> <20051226105822.538a31d9.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051226105822.538a31d9.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2005 at 10:58:22AM -0800, Randy.Dunlap wrote:
> On Mon, 26 Dec 2005 20:28:40 +0200 Jaco Kroon wrote:
> > For the moment though I'm quickly hacking together a bash script that
> > wraps the sendmail binary that can be used specifically for submitting
> > patches (the intent is to perform certain checks for Signed-of-by lines,
> > correct [PATCH] subject and so forth).  If anybody else is interrested
> > I'd be more than happy to share (albeit I suspect the usefullness will
> > be seriously limited).
> 
> Greg KH and Paul Jackson have both written scripts for this.
> And there may be one in the quilt package.
> 
> Paul's (python) is at
>   http://www.speakeasy.org/~pj99/sgi/sendpatchset
> I don't recall where Greg's is (perl).

Greg's has been hacked at a bit to provide a little bit more of a user
interface, and is included in the Git source tree.  ("git-send-email").

When I added it, I made it use a few more perl modules, I think it
generally does the right thing.

It *does not* validate for things like Signed-off-by lines, though
admittedly, that wouldn't be hard ot add.

> 
> ---
> ~Randy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 

Ryan Anderson
  sometimes Pug Majere
