Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbVLKGtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVLKGtk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 01:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVLKGtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 01:49:40 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:56125 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932235AbVLKGtk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 01:49:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=krF/NUS9mp+ViBb0Wf95FsK7q4roY1M7JzR7qjAbun9I9N/av8r8ma4IxuoeJ3GuzVFR9eqhgZWDAk+ETdhuzEPQRQFplDAbtOQJy2EFmLR6brgg/lnfGPHRB+g+LEICf+ietr6RxPHeHLs/qY724cLnta/1MwYt4ifSqT2QJFc=
Message-ID: <81083a450512102249u308ebdbcla9594f8fa57d283f@mail.gmail.com>
Date: Sun, 11 Dec 2005 12:19:39 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [BUG] Early Kernel Panic with 2.6.15-rc5
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20051211063522.GA23621@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <81083a450512102211r608cee8wc16cc19565a1488f@mail.gmail.com>
	 <81083a450512102226q1443f09bof0d3ba2bd5a1be2@mail.gmail.com>
	 <20051211063522.GA23621@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/05, Greg KH <greg@kroah.com> wrote:
> On Sun, Dec 11, 2005 at 11:56:08AM +0530, Ashutosh Naik wrote:
> > CONFIG_HOTPLUG_PCI_PCIE=y
>
> Change this to "m" or "n" and the oops should go away.  It's a known
> problem that is being worked on, but will probably take a while to get
> done.
>
> Do you really have a pci express hotplug controller on this machine?

Yeh, the Oops went away when I did  CONFIG_HOTPLUG_PCI_PCIE=n.

If its a known bug and will take a while to get done, maybe the
feature should not be included in 2.6.15 ( if it is not fixed until
then). Because a release kernel should theoretically never break. What
say?

Regards and Thanks
Ashutosh N
