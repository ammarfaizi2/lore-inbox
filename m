Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277339AbRJEOFR>; Fri, 5 Oct 2001 10:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277364AbRJEOFI>; Fri, 5 Oct 2001 10:05:08 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:9900 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S277339AbRJEOFB>;
	Fri, 5 Oct 2001 10:05:01 -0400
To: Linux Bigot <linuxopinion@yahoo.com>
Cc: Kurt Ferreira <kferreir@esscom.com>, linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address
In-Reply-To: <20011003214858.97073.qmail@web14807.mail.yahoo.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 05 Oct 2001 16:04:04 +0200
In-Reply-To: Linux Bigot's message of "Wed, 3 Oct 2001 14:48:58 -0700 (PDT)"
Message-ID: <d3r8sitc8b.fsf@lxplus014.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Linux" == Linux Bigot <linuxopinion@yahoo.com> writes:

Linux> oops! I am sorry. I did not meant "pci_unmap_single"
Linux> pci_unmap_single.

Linux> I meant to get a routine which does exactly opposite of what
Linux> pci_map_single does, i.e., give me a virtual address for a dma
Linux> address.

Because it is cheaper for you to keep both addresses in the driver
than it is to implement a database to keep track of it for you.

Jes
