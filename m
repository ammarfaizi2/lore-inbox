Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266457AbUAOJRO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 04:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266461AbUAOJRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 04:17:14 -0500
Received: from cliff.cse.wustl.edu ([128.252.166.5]:33777 "EHLO
	cliff.cse.wustl.edu") by vger.kernel.org with ESMTP id S266457AbUAOJRN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 04:17:13 -0500
Date: Thu, 15 Jan 2004 03:17:12 -0600 (CST)
From: Cheng Huang <cheng@cs.wustl.edu>
To: linux-kernel@vger.kernel.org
cc: cheng@cse.wustl.edu
Subject: Hang with Promise Ultra100 TX2 (kernel 2.4.18)
Message-ID: <Pine.GSO.4.58.0401150308350.1943@siesta.cs.wustl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to use kernel 2.4.18 because I need to install KURT (realtime
linux) with it. However, my system hangs on boot with the following
message:

PDC20268: not 100% native mode: will probe irqs later
PDC20268: ROM enabled at 0xff900000
    ide2: BM-DMA at 0xfcc0-0xfcc7, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xfcc8-0xfccf, BIOS settings: hdg:pio, hdh:pio

I have tried tricks I could find in through google, like setting boot
parameters "hde=4866,255,63 hde=noprobe hdg=24321,255,163 hdg=noprobe".
But it didn't work.

Could anybody provide some clue about how to fix this problem? Thanks
very much.

-- Cheng
