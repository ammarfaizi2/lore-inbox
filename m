Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVFWGrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVFWGrk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbVFWGqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:46:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:18827 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262363AbVFWGUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:20:54 -0400
Date: Wed, 22 Jun 2005 23:20:45 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
Message-ID: <20050623062045.GA11638@kroah.com>
References: <42B9FCAE.1000607@pobox.com> <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org> <42BA14B8.2020609@pobox.com> <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org> <42BA1B68.9040505@pobox.com> <Pine.LNX.4.58.0506221929430.11175@ppc970.osdl.org> <42BA271F.6080505@pobox.com> <Pine.LNX.4.58.0506222014000.11175@ppc970.osdl.org> <42BA45B1.7060207@pobox.com> <Pine.LNX.4.58.0506222225010.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506222225010.11175@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 10:58:13PM -0700, Linus Torvalds wrote:
> And I suggested that if you want that, then you pull on the TAG. You take 
> my modification, you test it, and you see if
> 
> 	git fetch tag ..repo.. tagname
> 
> works.

Hm, that doesn't work right now.  Both:
  git fetch rsync://rsync.kernel.org/pub/scm/linux/kernel/git/chrisw/linux-2.6.12.y.git tag v2.6.12.1
or
  git fetch tag rsync://rsync.kernel.org/pub/scm/linux/kernel/git/chrisw/linux-2.6.12.y.git v2.6.12.1

die.  Or am I just trying to take a point you were making about not
pulling all tags (which I can live with, just was not aware it was this
way, and I agree that it does offer up a lot of possiblities of me using
local tags in the future), and taking it literally?

thanks,

greg k-h
