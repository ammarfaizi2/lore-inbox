Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271870AbRHUVzj>; Tue, 21 Aug 2001 17:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271872AbRHUVz2>; Tue, 21 Aug 2001 17:55:28 -0400
Received: from mail.myrio.com ([63.109.146.2]:37626 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S271870AbRHUVzW>;
	Tue, 21 Aug 2001 17:55:22 -0400
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211C9D4@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Backporting drivers from 2.4 to 2.2
Date: Tue, 21 Aug 2001 14:21:34 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there a document somewhere that has some hints and tips for
backporting 2.4 drivers to the 2.2 series?  I have the O'Reilly
Linux Device Drivers (second edition) book by Rubini and Corbet, 
but it's a little thin on this problem.

Specifically, the new 2.4 PCI-related functions like:
pci_alloc_consistent, pci_free_consistent, pci_enable_device...

>From this newbie's point of view, it seems that it would be really 
nice to have a little library of functions that wrap the older 2.2 
style interface to provide the 2.4-style functions...  or is this
impossible to do in a general way?

Thanks for any advice...

Torrey Hoffman
torrey.hoffman@myrio.com
