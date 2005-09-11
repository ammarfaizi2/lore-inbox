Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbVIJXp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVIJXp2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 19:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVIJXp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 19:45:28 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:58075 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932384AbVIJXp1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 19:45:27 -0400
Subject: Re: [PATCH] (i)stallion remove
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Jiri Slaby <jirislaby@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050910233956.GG4770@parisc-linux.org>
References: <200509101221.j8ACL9XI017246@localhost.localdomain>
	 <43234860.7050206@pobox.com> <43234972.3010003@gmail.com>
	 <20050910211711.GA13660@suse.de> <4323518E.9060407@gmail.com>
	 <432352F0.1080502@pobox.com> <432360A2.7040608@gmail.com>
	 <1126397023.30449.14.camel@localhost.localdomain>
	 <20050910233956.GG4770@parisc-linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 11 Sep 2005 01:10:29 +0100
Message-Id: <1126397429.30449.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-09-10 at 17:39 -0600, Matthew Wilcox wrote:
> > Nak-by: Alan Cox <alan@redhat.com>
> > 
> > Its still on my hitlist - I'm slowly fixing them all
> 
> Are you converting them to the new serial infrastructure at the same
> time?

No.. I thought I'd be old fashioned and know why they broke by doing one
thing at a time 8)

Some of these controllers would fit the serial infrastructure, others
have interesting locking (ISA window mapping for example) or DMA/polling
interfaces that don't yet seem to fit. 

Alan

