Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262672AbRFBTSV>; Sat, 2 Jun 2001 15:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262667AbRFBTSK>; Sat, 2 Jun 2001 15:18:10 -0400
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:47621 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S262669AbRFBTSA>; Sat, 2 Jun 2001 15:18:00 -0400
Message-ID: <3B193BE0.4B15ACEC@damncats.org>
Date: Sat, 02 Jun 2001 15:17:52 -0400
From: John Cavan <johnc@damncats.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.5-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: lk@mailandnews.com, linux-kernel@vger.kernel.org
Subject: Re: CUV4X-D lockup on boot
In-Reply-To: <E156E44-0001sS-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> At minimum you need the 1007 bios and to run noapic. As yet we don't know why
> or what the newer BIOS has done to make it boot at all

Actually, I'm running this board with MPS 1.1, BIOS version 1007, and
APIC enabled without problem. Current kernel is 2.4.5-ac5, no lockups,
no boot failures, full access to my USB, etc.

With the older BIOS revision, you definitely need to have "noapic" as an
option. For the latest BIOS, just ensure that you set MPS 1.4 support
off.

John
