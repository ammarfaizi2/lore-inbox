Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136134AbRAMEpR>; Fri, 12 Jan 2001 23:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136150AbRAMEpH>; Fri, 12 Jan 2001 23:45:07 -0500
Received: from james.kalifornia.com ([208.179.0.2]:19288 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S136134AbRAMEos>; Fri, 12 Jan 2001 23:44:48 -0500
Message-ID: <3A5FDD3B.AA0906E8@linux.com>
Date: Fri, 12 Jan 2001 20:44:43 -0800
From: David Ford <david@linux.com>
Reply-To: david+validemail@kalifornia.com
Organization: Talon Technology, Intl.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Landley <telomerase@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG in 2.4.0: dd if=/dev/random of=out.txt bs=10000 count=100
In-Reply-To: <20010113035314.316.qmail@web5205.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

> If I do the dd line in the title under 2.4.0 I get an
> out.txt file of 591 bytes.

It isn't broken, you have no more entropy.  You must have some system
activity of various sorts before you regain some entropy.  Moving the mouse
around, hitting keys, etc, will slowly add more entropy.

-d


-- ---NOTICE

-- fwd: fwd: fwd: type emails will be deleted automatically.
      "There is a natural aristocracy among men. The grounds of this are
      virtue and talents", Thomas Jefferson [1742-1826], 3rd US President



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
