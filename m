Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268833AbRG0LMC>; Fri, 27 Jul 2001 07:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268832AbRG0LLw>; Fri, 27 Jul 2001 07:11:52 -0400
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:52353 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S268835AbRG0LLe>; Fri, 27 Jul 2001 07:11:34 -0400
Message-ID: <3B614BDB.BE13848B@randomlogic.com>
Date: Fri, 27 Jul 2001 04:09:15 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: TYan K7 Thunder: AMD-760 MP support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>From what I've seen in the 2.4-2 kernel (RH 7.1 stock kernel), the
AMD-760 MP chipset is not directly supported. It looks as though the
Host bridge, PCI bridge, ISA bridge, IDE, and AGP all have different
ID's than what the drivers are looking for, and since they don't match a
known AMD ID, they fall back to generic support, which works OK for some
things (like AGP), but I suspect that my ATA100 is not fully functional
and I can't access the Winbond chip through the ISA bridge (the SMBus is
not detected).

NOTE: Looking at AMDs Rev. documents, the current version of the chipset
probably has different IDs than pre-production boards did. My chips are
(fortunately, because the previous versions had non-functional AGP and
other issues) the newest release as per their documentation.

Do the newer kernel releases support the 760 MP chipset? Will they
anytime soon? (If not I will see if I can put it in myself.)

Thanks,

PGA

-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
