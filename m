Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVBBF7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVBBF7n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 00:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVBBF7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 00:59:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45518 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261435AbVBBF7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 00:59:41 -0500
Date: Tue, 1 Feb 2005 21:59:36 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       zaitcev@redhat.com
Subject: Re: Patch to add usbmon
Message-ID: <20050201215936.029be631@localhost.localdomain>
In-Reply-To: <1107293870.9652.76.camel@pegasus>
References: <20050131212903.6e3a35e5@localhost.localdomain>
	<20050201071000.GF20783@kroah.com>
	<20050201003218.478f031e@localhost.localdomain>
	<1107256383.9652.26.camel@pegasus>
	<20050201095526.0ee2e0f4@localhost.localdomain>
	<1107293870.9652.76.camel@pegasus>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Feb 2005 22:37:50 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:

> I think if cat is the prefered tool for viewing this file then it should
> be more human readable. If not, then a binary format should be choosen.
> Maybe we can implement both. Is this possible?

Yes. Now you know why files were split as they were.

> > But if you or someone else were to hack on something like usbdump(1),
> > it would be peachy, I think.
> 
> I can start with usbdump if we agree on an interface. I personally would
> prefer a binary interface for that.

If you want to start scoping it, it's fine by me. I was going to concentrate
on fixing what's needed first, such as getting control setup packets captured
and things like that.

-- Pete
