Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132406AbRDCSMT>; Tue, 3 Apr 2001 14:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132413AbRDCSMA>; Tue, 3 Apr 2001 14:12:00 -0400
Received: from sangam.sce.carleton.ca ([134.117.4.4]:43146 "EHLO
	sangam.sce.carleton.ca") by vger.kernel.org with ESMTP
	id <S132405AbRDCSL6>; Tue, 3 Apr 2001 14:11:58 -0400
Message-ID: <3ACA123D.1090200@sce.carleton.ca>
Date: Tue, 03 Apr 2001 14:11:09 -0400
From: john knox <jknox@sce.carleton.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.14-6.1.1 i686; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: gigabit bonding
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi -

I have 2 dell power edge 6300 boxes,
each with 4 processors and 2 intel
717037 ethernet cards running rh 6.2,
kernel 2.2.14-6.1.1smp.  I have
installed the latest intel nic driver
that I could find - v3.0.7.  The machines
are identical except for the scsi
controllers.

On one machine, I could bond the cards
to one ip and all was well - on the
other, the cards worked if brought up
singly, but bonding never set the mac
of the 2nd card to that of the 1st,
although ifenslave doesn't report
errors.  I can change the mac with
ifconfig and the card(s) work fine.

I tried swapping the 2 pairs of cards
from one machine to the other - now
neither pair will bond, although all
4 still work singly.

Any guesses as to where I can go next?

	john

