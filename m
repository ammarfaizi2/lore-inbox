Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314194AbSDVNnN>; Mon, 22 Apr 2002 09:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314196AbSDVNnM>; Mon, 22 Apr 2002 09:43:12 -0400
Received: from swan.nt.tuwien.ac.at ([128.131.67.158]:17047 "EHLO
	swan.nt.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S314194AbSDVNnM>; Mon, 22 Apr 2002 09:43:12 -0400
To: "Martin Bene" <martin.bene@icomedias.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: AW: nbd + raid1 + 2.4.19-pre7
In-Reply-To: <fa.mha9d8v.7i2m82@ifi.uio.no>
From: Thomas Zeitlhofer <tzeitlho+lkml@nt.tuwien.ac.at>
Date: 22 Apr 2002 15:43:06 +0200
Message-ID: <yzuofgbkfx1.fsf@swan.nt.tuwien.ac.at>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin Bene" <martin.bene@icomedias.com> writes:

> Any special reason you're trying to do build your network replicated
> disk using nbd+raid1? I've found the drbd driver
> (http://www.linbit.com/en/drbd) quite useful for exactly this kind of
> setup. 

I tried drbd and enbd, in both cases I got an oops when trying to
access the block-device (using 2.4.18-ac3).  But following a previous
thread about eNBD drbd seems to be working fine with plain 2.4.18. So
of course, both may be an option...

Basically, I tried nbd because it seemed pretty stable when compared
to the other solutions - except for the issues I mentioned.

Thomas
