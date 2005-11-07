Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbVKGRsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbVKGRsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbVKGRsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:48:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:26853 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965002AbVKGRsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:48:18 -0500
Date: Mon, 7 Nov 2005 09:31:57 -0800
From: Greg KH <greg@kroah.com>
To: "Marco d'Itri" <md@Linux.IT>
Cc: linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: 2.6.14, udev: unknown symbols for ehci_hcd
Message-ID: <20051107173157.GA16465@kroah.com>
References: <436CD1BC.8020102@t-online.de> <20051105162503.GC20686@kroah.com> <436D9BDE.3060404@t-online.de> <20051106215158.GB3603@kroah.com> <20051107113329.GA7632@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107113329.GA7632@wonderland.linux.it>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 12:33:29PM +0100, Marco d'Itri wrote:
> On Nov 06, Greg KH <greg@kroah.com> wrote:
> 
> > This seems to be a Debian issue for some odd reason, I suggest filing a
> > bug against the udev package (or just tagging onto the existing bug for
> > this problem, I've seen it in there already...)
> The reason this is usually seen only on Debian systems is that I am the
> first one who shipped an udev package which runs many parallel modprobe
> commands, but this is a genuine kernel/modprobe bug.

I'm pretty sure OpenSuSE 10.0 does the same thing, and I don't think
anyone has reported the same kind of bugs there.  Makes me wonder what
is really happening here...

thanks,

greg k-h
