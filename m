Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276832AbRJCCFq>; Tue, 2 Oct 2001 22:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276834AbRJCCFf>; Tue, 2 Oct 2001 22:05:35 -0400
Received: from a1a90191.sympatico.bconnected.net ([209.53.18.133]:25219 "EHLO
	continuum.cm.nu") by vger.kernel.org with ESMTP id <S276832AbRJCCFU>;
	Tue, 2 Oct 2001 22:05:20 -0400
Date: Tue, 2 Oct 2001 19:05:47 -0700
From: Shane Wegner <shane@cm.nu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.11-pre2 fs/buffer.c: invalidate: busy buffer
Message-ID: <20011002190547.A3323@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am getting the following out of fs/buffer.c immediately
after bootup.  The kernel is 2.4.11-pre2 when the message
was added.

Oct  2 17:35:08 continuum kernel: invalidate: busy buffer
Oct  2 17:35:08 continuum last message repeated 7 times

I assume this is an error though it doesn't seem to say so. 
It's consistent in that it happens on every bootup however
the repeat count can vary between 7 and 10 times.

Everything is ext2 here though LVM and MD (raid0/linear)
are both being used.

Regards,
Shane

-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
