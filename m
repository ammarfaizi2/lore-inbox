Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268370AbRG3Gza>; Mon, 30 Jul 2001 02:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268377AbRG3GzU>; Mon, 30 Jul 2001 02:55:20 -0400
Received: from biltenmail.bilten.metu.edu.tr ([144.122.246.3]:55819 "EHLO
	biltenmail.bilten.metu.edu.tr") by vger.kernel.org with ESMTP
	id <S268370AbRG3GzD>; Mon, 30 Jul 2001 02:55:03 -0400
Message-ID: <3B65052A.25DFA8C2@bilten.metu.edu.tr>
Date: Mon, 30 Jul 2001 09:56:42 +0300
From: Muzaffer Ozakca <muzaffer.ozakca@bilten.metu.edu.tr>
Organization: Tubitak - Bilten
X-Mailer: Mozilla 4.76 [en] (Win95; U)
X-Accept-Language: tr
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Questions reg. mm
Content-Type: text/plain; charset=iso-8859-9
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello,

I'm trying to implement a checkpoint/restart mechanism in the kernel.
But, there are some points that are not very clear, I'd like to ask.
Mostly in MM.

1) I will save and then later restore the contents of vmas'. Should I
store the protections, etc. of every page contained by these vmas or
setting protections just on vmas is adequate?

2) How to know when to use one of these functions for allocation:
kmalloc(), get_free_page(), vmalloc(), mmap() -what else-?

3) Is this the right list to send out the questions of above kind?
Because I will have more questions about the kernel..

Thanks.

--
muzaffer
