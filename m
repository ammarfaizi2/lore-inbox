Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbVLGRAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbVLGRAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 12:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbVLGRAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 12:00:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:29610 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751207AbVLGRAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 12:00:46 -0500
Date: Wed, 7 Dec 2005 08:59:46 -0800
From: Greg KH <gregkh@suse.de>
To: Otavio Salvador <otavio@debian.org>
Cc: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       ehabkost@mandriva.com
Subject: Re: [PATCH 00/10] usb-serial: Switches from spin lock to atomic_t.
Message-ID: <20051207165946.GA28393@suse.de>
References: <20051206095610.29def5e7.lcapitulino@mandriva.com.br> <20051207164118.GA28032@suse.de> <87vey0hmok.fsf@nurf.casa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vey0hmok.fsf@nurf.casa>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 02:55:07PM -0200, Otavio Salvador wrote:
> Greg KH <gregkh@suse.de> writes:
> 
> > That's the right thing to do, so I'm not going to take this patch series
> > right now because of that.  If you all want to work on moving to use the
> > serial core, I would love to see that happen.
> 
> But wouldn't be better to have this intermediary solution merged while
> someone work on this conversion?

No, why do you say that?  It doesn't fix a bug at all, and it isn't a
"solution" to any existing problem.

thanks,

greg k-h
