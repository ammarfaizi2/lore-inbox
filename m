Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVFWB70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVFWB70 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVFWB4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:56:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40091 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262005AbVFWByY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:54:24 -0400
Date: Wed, 22 Jun 2005 18:56:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
In-Reply-To: <42BA14B8.2020609@pobox.com>
Message-ID: <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <20050622230905.GA7873@kroah.com>
 <Pine.LNX.4.58.0506221623210.11175@ppc970.osdl.org> <42B9FCAE.1000607@pobox.com>
 <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org> <42BA14B8.2020609@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Jun 2005, Jeff Garzik wrote:
>
> With BK, tags came with each pull.  With git, you have to go "outside 
> the system" (rsync) just get the new tags.

You don't have to use rsync, and you don't have to go outside the system. 
That was my point: you can use "git-ssh-pull" to pull the tags.

But yes, you have to explicitly ask for them by name, ie the other side 
has to let you know: "Oh, btw, I created a 'xyz' tag for you". And having 
another helper script to hide the details of how git-*-pull handles tags 
is obviously also a good idea, although it's pretty low on my list of 
things to worry about.

		Linus
