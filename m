Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032196AbWLGNV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032196AbWLGNV0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 08:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032183AbWLGNV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 08:21:26 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:58471 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032197AbWLGNVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 08:21:25 -0500
Message-ID: <1165497684.45781554b18a6@imp4-g19.free.fr>
Date: Thu, 07 Dec 2006 14:21:24 +0100
From: Remi Colinet <remi.colinet@free.fr>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic at boot with recent pci quirks patch
References: <45771F0B.8090708@tuxrocks.com> <20061206232714.54ec6f7b@localhost.localdomain> <1165450859.45775e6b5e194@imp3-g19.free.fr> <45776FBC.3040705@tuxrocks.com>
In-Reply-To: <45776FBC.3040705@tuxrocks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 81.255.27.251
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Selon Frank Sorenson <frank@tuxrocks.com>:

> Remi Colinet wrote:
> > Frank Sorenson <frank@tuxrocks.com> wrote:
> >
> >> The latest -git tree panics at boot for me.  git-bisect traced the
> > offending commit to:
> >> 368c73d4f689dae0807d0a2aa74c61fd2b9b075f is first bad commit
> >> commit 368c73d4f689dae0807d0a2aa74c61fd2b9b075f
> >> Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
> >> Date:   Wed Oct 4 00:41:26 2006 +0100
> >>
> >>     PCI: quirks: fix the festering mess that claims to handle IDE quirks
> >>
> >> Hardware is a Dell Inspiron E1705 laptop running FC6 x86_64.
> >>
> >
> > Could you try the following patch (already included in mm tree)?
> >
> > http://www.uwsg.indiana.edu/hypermail/linux/kernel/0611.1/1568.html
> >
> > Remi
>
> Yes, that patch does seem to fix the problem.  Is it the right fix?
>
Yes, it is.

As previously told by Alan Cox, the fix is going to be included in the Linus git
tree soon when the libata patches will be merged.

Remi


