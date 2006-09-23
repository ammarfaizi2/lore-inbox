Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWIWWQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWIWWQG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 18:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWIWWQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 18:16:06 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:19908 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750794AbWIWWQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 18:16:04 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm] swsusp: Add support for swap files
Date: Sat, 23 Sep 2006 22:30:54 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
References: <200609231158.00147.rjw@sisk.pl> <20060923101724.GA20778@elf.ucw.cz>
In-Reply-To: <20060923101724.GA20778@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609232230.54769.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 23 September 2006 12:17, Pavel Machek wrote:
> Hi!
> 
> > The following series of patches makes swsusp support swap files.
> > 
> > For now, it is only possible to suspend to a swap file using the in-kernel
> > swsusp and the resume cannot be initiated from an initrd.
> > 
> > [Note to Pavel: I have added a couple of paragraphs to the documentation to
> > clarify some things pointed out by Dave, but I hope the ACK still applies. ;-) ]
> 
> Yes, thanks.
> 
> Out of my curiosity... can swap on file work on filesystems with 1K
> blocksize? ext2 can do that, iirc...

I thinks so.  Having looked at the code, I don't see any particular reason
why not.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

