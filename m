Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751610AbWCUMsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbWCUMsB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 07:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbWCUMsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 07:48:01 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:55820 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751609AbWCUMsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 07:48:00 -0500
Date: Tue, 21 Mar 2006 13:47:55 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       davej@redhat.com
Subject: Re: [GIT PATCH] Remove devfs from 2.6.16
Message-ID: <20060321124755.GA83095@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Arjan van de Ven <arjan@infradead.org>, Greg KH <gregkh@suse.de>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, davej@redhat.com
References: <20060320212338.GA11571@kroah.com> <20060320235846.GA84147@dspnet.fr.eu.org> <1142925322.3077.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142925322.3077.12.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 08:15:22AM +0100, Arjan van de Ven wrote:
> On Tue, 2006-03-21 at 00:58 +0100, Olivier Galibert wrote:
> > On Mon, Mar 20, 2006 at 01:23:38PM -0800, Greg KH wrote:
> > > They are the same "delete devfs" patches that I submitted for 2.6.12 and
> > > 2.6.13 and 2.6.14 and 2.6.15.  It rips out all of devfs from the kernel
> > > and ends up saving a lot of space.  Since 2.6.13 came out, I have seen
> > > no complaints about the fact that devfs was not able to be enabled
> > > anymore, and in fact, a lot of different subsystems have already been
> > > deleting devfs support for a while now, with apparently no complaints
> > > (due to the lack of users.)
> > 
> > I'm an occasional user.  I'm just able to add a config entry by hand.
> > 
> > Devfs for block devices is required for the fedora core 3 install
> > kernel.  
> 
> that is not true; Fedora Core 3 does not even have devfs enabled, and
> neither RHL nor FC has shipped devfsd like forever
> 
> FC3 uses udev

The _install_ kernel does not use udev.  It uses a mix of static /dev
and whatever it is which creates the block devices, but after checking
is not devfs after all, sorry about the mistake.

  OG.

