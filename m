Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWFSIwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWFSIwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWFSIwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:52:20 -0400
Received: from iona.labri.fr ([147.210.8.143]:9391 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S1750777AbWFSIwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:52:19 -0400
Date: Mon, 19 Jun 2006 10:52:17 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Greg KH <gregkh@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: [GIT PATCH] Remove devfs from 2.6.17
Message-ID: <20060619085217.GG4253@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Greg KH <gregkh@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, greg@kroah.com
References: <20060618221343.GA20277@kroah.com> <20060618230041.GG4744@bouh.residence.ens-lyon.fr> <4495F5C3.1030203@zytor.com> <20060619031521.GA4651@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060619031521.GA4651@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH, le Sun 18 Jun 2006 20:15:21 -0700, a écrit :
> On Sun, Jun 18, 2006 at 05:54:27PM -0700, H. Peter Anvin wrote:
> > It would be nice if udev could be fed not just from the kernel, but from 
> > the repository of modules that are available for loading.  That may 
> > require additional module information.
> 
> There's no reason it could not be, but usually a simple, "modprobe loop"
> works good enough for everyone :)

Not for non-root people. (And yes, they may want to do non-root things
with such virtual devices, in the dummy sequencer case for instance).

Samuel
