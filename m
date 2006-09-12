Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030379AbWILTmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbWILTmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 15:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbWILTmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 15:42:14 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:19378 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1030379AbWILTmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 15:42:13 -0400
Date: Tue, 12 Sep 2006 21:47:14 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
Message-ID: <20060912194714.GA1970@uranus.ravnborg.org>
References: <20060830062338.GA10285@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060830062338.GA10285@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 11:23:38PM -0700, Greg KH wrote:
> 
> So, here's the code.  I think it does a bit too much all at once, but it
> is an example of how this can be done.  This is working today in some
> industrial environments, successfully handling hardware controls of very
> large and scary machines.

At present it is named uio in -mm. But that seems to conflict with a
few cases (uio.h + Solaris).

How about:
Universal User IO => uuio

A quick google did not turn up anything conflicting.

[Lost the mail thread about naming so replying to this old mail instead].

	Sam
