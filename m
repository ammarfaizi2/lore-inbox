Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbVEESU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVEESU3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 14:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVEESU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 14:20:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:32957 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262166AbVEESUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 14:20:24 -0400
Date: Thu, 5 May 2005 11:22:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Dave Kleikamp <shaggy@austin.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git pull] jfs update
In-Reply-To: <427A630E.5000008@pobox.com>
Message-ID: <Pine.LNX.4.58.0505051119440.2328@ppc970.osdl.org>
References: <20050504204744.DA0A0849AD@kleikamp.dyn.webahead.ibm.com>
 <Pine.LNX.4.58.0505041437060.2328@ppc970.osdl.org> <427A630E.5000008@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 May 2005, Jeff Garzik wrote:
> 
> FWIW I'm definitely interested in some sort of pull mechanism where I 
> can say "pull from foo://.../libata-2.6.git/HEAD-for-linus" also.

I already changed my scripts to be able to do that. They default to HEAD, 
but if you tell them something else, they'll get that instead.

So I'd do a

	git-pull-script foo://.../libata-2.6.git/ HEAD-for-linus

except right now my pull script only works with rsync or ssh, not http. 
I'll fix that up asap.

		Linus
