Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbWECATP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbWECATP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 20:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbWECATP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 20:19:15 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:45727 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S965053AbWECATP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 20:19:15 -0400
Date: Tue, 2 May 2006 18:19:14 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, Arjan van de Ven <arjan@linux.intel.com>,
       greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, airlied@linux.ie, pjones@redhat.com,
       akpm@osdl.org
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Message-ID: <20060503001914.GA9609@parisc-linux.org>
References: <1146300385.3125.3.camel@laptopd505.fenrus.org> <9e4733910605020938h6a9829c0vc70dac326c0cdf46@mail.gmail.com> <44578C92.1070403@linux.intel.com> <9e4733910605020959k7aad853dn87d73348cbcf42cd@mail.gmail.com> <44579028.1020201@linux.intel.com> <9e4733910605021013h17b72453v3716f68a2cebdee1@mail.gmail.com> <1146594457.32045.91.camel@laptopd505.fenrus.org> <9e4733910605021200y6333a67sd2ff685f666cc6f9@mail.gmail.com> <21d7e9970605021440s6cdc3895t57617e5fad6c5050@mail.gmail.com> <9e4733910605021452r3aec1035pa475b701b2c3563c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910605021452r3aec1035pa475b701b2c3563c@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 05:52:09PM -0400, Jon Smirl wrote:
> Have you seen this method of getting root from X?
> http://www.cansecwest.com/slides06/csw06-duflot.ppt
> It is referenced from Theo de Raadt interview on kerneltrap
> http://kerneltrap.org/node/6550

That's a great indication of why securelevels aren't.
It pretty much fits the Linux model of "once you're root, you can do
anything".  The POSIX Capabilities really don't help either.
I suppose SELinux might be able to help, but I don't care to get into
that discussion here ;-)
