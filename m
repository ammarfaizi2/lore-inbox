Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSGWCfo>; Mon, 22 Jul 2002 22:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315458AbSGWCfo>; Mon, 22 Jul 2002 22:35:44 -0400
Received: from moutvdom.kundenserver.de ([195.20.224.200]:62699 "EHLO
	moutvdomng3.kundenserver.de") by vger.kernel.org with ESMTP
	id <S315457AbSGWCfn>; Mon, 22 Jul 2002 22:35:43 -0400
Date: Mon, 22 Jul 2002 20:38:51 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Another DMA question
Message-ID: <Pine.LNX.4.44.0207222035420.3241-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

How can I get the _real_ address of a pci_map_single area, if needed? The 
thing bus_to_virt() did, basically. My problem is that I have code which 
changed the first byte of a buffer of stuff read via DMA, and I can't 
because the previous user did bus_to_virt() to get a pointer into that. I 
don't know how to get another pointer.

After all the confusion, is the question clear?

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

