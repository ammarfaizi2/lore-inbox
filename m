Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbTEFL0a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 07:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbTEFL0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 07:26:30 -0400
Received: from mailsrv1-tu0.sanger.ac.uk ([193.62.206.128]:55056 "EHLO
	mailsrv1.sanger.ac.uk") by vger.kernel.org with ESMTP
	id S262562AbTEFL00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 07:26:26 -0400
Message-ID: <3EB79ECE.4010709@thekelleys.org.uk>
Date: Tue, 06 May 2003 12:38:54 +0100
From: Simon Kelley <simon@thekelleys.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.2.1) Gecko/20030121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Binary firmware in the kernel - licensing issues.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently working on the drivers for Atmel PCMCIA and PCI wireless
adaptors with the aim of getting up to snuff for inclusion in
the mainline kernel.

I'm working from source drivers released by Atmel themselves last
year under the GPL so there are no problems with the code - each
source file from Atmel has a GPL notice at the top.

BUT. These things need firmware loaded, at least the ones without
built-in flash. The Atmel drivers come with binary firmware
as header files full of hex, with the following notice.

------------------------------------------------------------------
             Copyright (c) 1999-2000 by Atmel Corporation

This software is copyrighted by and is the sole property of Atmel
Corporation.  All rights, title, ownership, or other interests
in the software remain the property of Atmel Corporation.  This
software may only be used in accordance with the corresponding
license agreement.  Any un-authorized use, duplication, transmission,
distribution, or disclosure of this software is expressly forbidden. 


This Copyright notice may not be removed or modified without prior
written consent of Atmel Corporation. 


Atmel Corporation, Inc. reserves the right to modify this software
without notice.

Atmel Corporation.
2325 Orchard Parkway               literature@atmel.com
San Jose, CA 95131                 http://www.atmel.com
------------------------------------------------------------------

It isn't clear what the license agreement referred to in the above
actually is, but I don't think it's reasonable to just assume it's the
GPL and shove these files into the kernel as-is.

I shall contact Atmel for advice and clarification but my question for
the list is, what should I ask them to do? It's unlikely that they will
release the source to the firmware and even if they did I wouldn't want
firmware source  in the kernel tree since the kernel-build toolchain
won't be enough to build the firmware. What permissions do they have to
give to make including this stuff legal and compatible with the rest of
the kernel?

Given the current SCO-IBM situation I don't want to be responsible for
introducing any legally questionable IP into the kernel tree.

This situation must have come up before, how was it solved then?

Cheers,

Simon.

