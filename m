Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbTK2RA2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 12:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263828AbTK2RA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 12:00:28 -0500
Received: from havoc.gtf.org ([63.247.75.124]:47540 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263827AbTK2RAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 12:00:23 -0500
Date: Sat, 29 Nov 2003 11:56:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
Cc: unlisted-recipients: no@gtf.org, To-header@gtf.org, on@gtf.org,
       "input <"@gtf.org, ;;;linux-kernel@vger.kernel.org;,
       marcush@onlinehome.de
Illegal-Object: Syntax error in Cc: addresses found on vger.kernel.org:
	Cc:	;linux-kernel@vger.kernel.org
			^-extraneous tokens in mailbox, missing end of mailbox
Illegal-Object: Syntax error in Cc: addresses found on vger.kernel.org:
	Cc:	;linux-kernel@vger.kernel.org
			^-extraneous tokens in mailbox, missing end of mailbox
Subject: Re: Silicon Image 3112A SATA trouble
Message-ID: <20031129165648.GB14704@gtf.org>
References: <3FC36057.40108@gmx.de> <3FC8BDB6.2030708@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC8BDB6.2030708@gmx.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 04:39:34PM +0100, Prakash K. Cheemplavam wrote:
> Holy Shit!
> 
> I just tried the libata driver and it ROCKSSSS! So far, at least.
> 
> I already wrote about the crappy SiI3112 ide driver, now with libata I 
> get >60mb/sec!!!! More then I get with windows.
> 
> Also tests with dd. This rocks. Lets see whether it likes swsup, as well...
> 
> So folks, try libata, as well.

Thanks :)

Note that (speaking technically) the SII libata driver doesn't mask all
interrupt conditions, which is why it's listed under CONFIG_BROKEN.  So
this translates to "you might get a random lockup", which some users
certainly do see.

For other users, the libata SII driver works flawlessly for them...

	Jeff



