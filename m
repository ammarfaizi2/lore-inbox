Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280687AbRKFXji>; Tue, 6 Nov 2001 18:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280690AbRKFXj2>; Tue, 6 Nov 2001 18:39:28 -0500
Received: from sweetums.bluetronic.net ([66.57.88.6]:54423 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S280687AbRKFXjM>; Tue, 6 Nov 2001 18:39:12 -0500
Date: Tue, 6 Nov 2001 18:39:01 -0500 (EST)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: <dank@trellisinc.com>
cc: Erik Andersen <andersen@codepoet.org>,
        Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <20011106224753.7D45EA3B90@fancypants.trellisinc.com>
Message-ID: <Pine.GSO.4.33.0111061820190.17287-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001 dank@trellisinc.com wrote:
>"code poet?"  you've plucked an 80 from the air.  regardless of what the
>kernel prints now and how it's limited (deep within drivers/block/genhd.c),
>there is no reference to this silent 63 via either explicit comment or
>pure code.  your code remains happily ignorant of any modification to this
>postcondition, and when that changes (as it surely will), you lose.  it's
>uninspired coding like the above that keeps the buffer overflow
>technique alive.

Exactly.  Just because the code _currently_ won't generate more than 63
chars doesn't mean it always will.  And who says the application will see
the true, kernel generated "/proc/partitions"? <raises eyebrow>

>c string processing is all of doable, mature, and meticulous.  "done
>properly by beginners" is not how i would describe it.

Experience shows beginners rarely get thing right the first time out. (Or
the second or third time if they are like some of my previous students.)

--Ricky


