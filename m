Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276380AbRJCPZn>; Wed, 3 Oct 2001 11:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276387AbRJCPZe>; Wed, 3 Oct 2001 11:25:34 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:20158 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S276380AbRJCPZU>;
	Wed, 3 Oct 2001 11:25:20 -0400
To: Linux Bigot <linuxopinion@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address
In-Reply-To: <20011003141156.17014.qmail@web14803.mail.yahoo.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 03 Oct 2001 17:25:42 +0200
In-Reply-To: Linux Bigot's message of "Wed, 3 Oct 2001 07:11:56 -0700 (PDT)"
Message-ID: <d3k7ycwxs9.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Linux" == Linux Bigot <linuxopinion@yahoo.com> writes:

Linux> All programmers I am relatively new to linux kernel. Please
Linux> advise what is the safe way to get the original virtaul address
Linux> from dma address e.g.,

You have to store the address you pass to pci_map_single() somewhere
in your data structures together with the dma address.

Jes
