Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVFWB4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVFWB4g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVFWB4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:56:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25243 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261972AbVFWBvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:51:09 -0400
Date: Wed, 22 Jun 2005 18:53:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
In-Reply-To: <42B9FF3A.4010700@pobox.com>
Message-ID: <Pine.LNX.4.58.0506221850030.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
 <42B9FF3A.4010700@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Jun 2005, Jeff Garzik wrote:
> 
> git-clone-script would indeed be nice, even if its only a 2-line script.

Ok, added. You can update your tutorial to make the initial setup of a 
kernel archive slightly less scary, ie it's now

	git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6
	cd linux-2.6
	git checkout

which looks almost user-friendly.

(Of course, since the rsync protocol doesn't know anything about git
consistency, if the mirroring is half-way, you'll end up with something
less than wonderful, and confusing. Details, details)

		Linus
