Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWIYUKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWIYUKj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbWIYUKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:10:39 -0400
Received: from xenotime.net ([66.160.160.81]:50342 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750912AbWIYUKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:10:38 -0400
Date: Mon, 25 Sep 2006 13:11:51 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Henne <henne@nachtwindheim.de>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata-piix: kerneldoc-error-on-ata_piixc.patch 2nd try
Message-Id: <20060925131151.4f73612c.rdunlap@xenotime.net>
In-Reply-To: <4518305C.3090906@pobox.com>
References: <451826BE.2040201@nachtwindheim.de>
	<4518305C.3090906@pobox.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2006 15:39:08 -0400 Jeff Garzik wrote:

> Henne wrote:
> > Heres a new version of the kerneldoc error in ata_piix.c
> > The old one which doesn't apply clean is in 2.6.18-mm1 and can be removed there if acked.
> > 
> > Greets,
> > Henne
> > 
> > From: Henrik Kretzschmar <henne@nachtwindheim.de>
> > 
> > Fixes an error in kerneldoc of ata_piix.c.
> > This is the 2nd try, written for 2.6.18-git4
> > Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
> 
> Several problems with your patch format:
> 
> 1) your subject line includes-a-bunch-of-words-separated-by-dashes, 
> which is incorrect.  Just use standard English.
> 
> 2) "2nd try" should be inside the brackets ("[", "]"), so that the 
> script removes it during merge
> 
> 3) All comments such as the first paragraph and "Greets, Henne" should 
> be moved underneath the "---" separator, so that they are not copied 
> into the kernel changelog verbatim.  You force people to hand-edit your 
> email before merging.
> 
> 4) No need for "From:" in the email body, it duplicates the email's 
> RFC822 From header.

I agree with all of these except #4.  Maybe you can reconcile your
preference with that in Documentation/SubmittingPatches, which
contains:

<quote>
The canonical patch message body contains the following:

  - A "from" line specifying the patch author.
</quote>

A patch submitter should not need to know the patch receiver's
personal preferences and vary patches based on those.


> 5) Another comment "This is the 2nd try, written for 2.6.18-git4" which 
> should be moved after the "---" separator.  Otherwise, it must be 
> hand-edited out.


---
~Randy
