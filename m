Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267737AbUHEP76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267737AbUHEP76 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 11:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267769AbUHEP5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 11:57:41 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:50877 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S267759AbUHEP5G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 11:57:06 -0400
From: David Brownell <david-b@pacbell.net>
To: Olaf Hering <olh@suse.de>
Subject: Re: [linux-usb-devel] [PATCH] proper bios handoff in ehci-hcd
Date: Thu, 5 Aug 2004 08:49:43 -0700
User-Agent: KMail/1.6.2
Cc: Pete Zaitcev <zaitcev@redhat.com>, Stuart_Hayes@Dell.com,
       whbeers@mbio.ncsu.edu, Gary_Lerhaupt@Dell.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <7A8F92187EF7A249BF847F1BF4903C046304CF@ausx2kmpc103.aus.amer.dell.com> <20040715093704.GA30351@suse.de> <20040805133914.GA8844@suse.de>
In-Reply-To: <20040805133914.GA8844@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408050849.43463.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 August 2004 06:39, Olaf Hering wrote:
>  On Thu, Jul 15, Olaf Hering wrote:
> 
> >  On Tue, Jul 13, David Brownell wrote:
> > 
> > > Instead, how about:  (a) longer timeout, 5 seconds to match OHCI's
> > > absurdly long default there; (b) change that "handoff failed" message
> > > to add "continuing anyway"; and (c) return 0 as you do, which I'm
> > > expecting is the key part of that patch.
> 
> David, what is the status with this bios problem?
> Can a patch like this patch go in?
> What could we lose if the error is ignored?

I submitted a very similar patch yesterday, not yet merged but
closer to what I described:

http://www.mail-archive.com/linux-usb-devel%40lists.sourceforge.net/msg26725.html
