Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131631AbRCODCa>; Wed, 14 Mar 2001 22:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131630AbRCODCK>; Wed, 14 Mar 2001 22:02:10 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:7099 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S131629AbRCODCE>;
	Wed, 14 Mar 2001 22:02:04 -0500
Message-ID: <3AB03062.475D4D62@mandrakesoft.com>
Date: Wed, 14 Mar 2001 22:00:50 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: New unaligned-accessed arch flag?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of putting arch-specific ifdefs in drivers, would it be
reasonable to add a per-arch flag UNALIGNED_PROFITABLE?  Arch-specific
ifdefs all over the default rx_copybreak values in net drivers are the
example I have in mind, but it seems like it would be good knowledge
that can be easily exposed to the rest of the kernel.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
