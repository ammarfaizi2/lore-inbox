Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284246AbRLZQ5n>; Wed, 26 Dec 2001 11:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283876AbRLZQ5d>; Wed, 26 Dec 2001 11:57:33 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:6929 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S282400AbRLZQ5R>; Wed, 26 Dec 2001 11:57:17 -0500
Date: Wed, 26 Dec 2001 13:43:01 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] MAX_MP_BUSSES increase
In-Reply-To: <200112200428.fBK4SNq29583@butler1.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.21.0112261341470.9842-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James, 

Don't remove the "#ifdef CONFIG_MULTIQUAD" on your patch: Let the old max
(32) for non-multiquad machines.

Please resend me the patch this way.

On Wed, 19 Dec 2001, James Cleverdon wrote:

> We've run into a bit of a problem with a forthcoming system.  The BIOS 
> reserves so many PCI bus numbers for hotplug when maxed out PCI expansion 
> box(es) are present that some arrays (mp_bus_id_to_node[], 
> mp_bus_id_to_pci_bus[], etc) overflow, splattering important variables.

