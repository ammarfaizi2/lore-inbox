Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVFHRRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVFHRRd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVFHRRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:17:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:63710 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261441AbVFHRJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:09:50 -0400
Date: Wed, 8 Jun 2005 10:11:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: Erik Mouw <erik@harddisk-recovery.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Linux v2.6.12-rc6
In-Reply-To: <17062.21286.601768.751853@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.58.0506081009540.2286@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
 <20050607130535.GD16602@harddisk-recovery.com> <Pine.LNX.4.58.0506070820170.2286@ppc970.osdl.org>
 <17062.21286.601768.751853@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Jun 2005, Paul Mackerras wrote:
> 
> This also affects gitk, which takes the first line of the commit
> message as the headline.  I could make gitk take the first paragraph
> (i.e. until the first blank line) as the headline but even that
> wouldn't help since you put a blank line between the "Automatic merge"
> line and the actual URL.  Could you leave out that blank line in
> future, or do you have a better suggestion?

I'll just make future messages much denser. They should now be just

	Merge repo

or

	Merge 'name' branch of <repo>

(and I may decide to replace "branch of" with "from" to make it even 
denser.)

		Linus
