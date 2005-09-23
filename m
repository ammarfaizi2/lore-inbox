Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbVIWQng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbVIWQng (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 12:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbVIWQng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 12:43:36 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:31935 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751113AbVIWQnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 12:43:35 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.14-rc2: USB storage-related #GP on x86-64
Date: Fri, 23 Sep 2005 18:43:50 +0200
User-Agent: KMail/1.8.2
Cc: torvalds@osdl.org, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200509231502.02344.rjw@sisk.pl> <20050923130658.GA11908@kroah.com>
In-Reply-To: <20050923130658.GA11908@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509231843.51432.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 23 of September 2005 15:06, Greg KH wrote:
> On Fri, Sep 23, 2005 at 03:02:01PM +0200, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > I've just triggered a general protection fault on Asus L5D (x86-64) by
> > unplugging a USB floppy.
> 
> Can you try the latest -git snapshots?  The scsi changes that should
> have fixed this went in after -rc2.

Tried -git3, works.  Tested with a pendrive instead of the floppy,
but I assume it doesn't matter?

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
