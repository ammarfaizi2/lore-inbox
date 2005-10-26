Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbVJZHs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbVJZHs1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 03:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbVJZHs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 03:48:27 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:16078 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932575AbVJZHs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 03:48:26 -0400
Date: Wed, 26 Oct 2005 09:48:24 +0200
From: Sander <sander@humilis.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Avuton Olrich <avuton@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: EDAC (was: Re: 2.6.14-rc5-mm1)
Message-ID: <20051026074824.GA7121@favonius>
Reply-To: sander@humilis.net
References: <20051024014838.0dd491bb.akpm@osdl.org> <3aa654a40510251055r33b2b8a5kbd5c53471a243851@mail.gmail.com> <1130265540.25191.55.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130265540.25191.55.camel@localhost.localdomain>
X-Uptime: 09:30:43 up 80 days, 18:55, 36 users,  load average: 2.86, 2.25, 2.07
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote (ao):
> On Maw, 2005-10-25 at 10:55 -0700, Avuton Olrich wrote:
> > After upgrading to 2.6.14-rc5-mm1 I have been greeted with:
> > 
> > PCI-Bridge- Detected Parity Error on 0000:00:08.0 0000:00:08.0
> 
> > ... I probably get a new one every minute or so. Is this new, perhaps
> > part of the new EDAC stuff? And what kind of adverse effect does this
> > have on my computer (the actual parity error)?
> 
> If the parity error is real then it would indicate a bad PCI transfer
> has occurred and data corrupted in the transfer. Unfortunately because
> some vendors don't use PCI parity checking much and some card vendors
> don't debug their products except on that OS there are some cards that
> generate spurious parity errors.
> 
> Can you send an lspci -vxx. That'll help the EDAC folk build up a view
> of what needs to be blacklisted.

Stupid question: should EDAC work on a Via Epia board? Because I see the
"Detected Parity Error" messages too (and a lot of them), but figured
that the option is just 'not an option' :-)

If it should work I'll be happy to send the error and lspci if that
helps.

-- 
Humilis IT Services and Solutions
http://www.humilis.net
