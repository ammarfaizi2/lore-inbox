Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130337AbRAKU0i>; Thu, 11 Jan 2001 15:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132448AbRAKU02>; Thu, 11 Jan 2001 15:26:28 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:28434 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S130337AbRAKU0O>; Thu, 11 Jan 2001 15:26:14 -0500
Message-ID: <3A5E16EB.5F30BF70@Hell.WH8.TU-Dresden.De>
Date: Thu, 11 Jan 2001 21:26:19 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange umount problem in latest 2.4.0 kernels
In-Reply-To: <Pine.GSO.4.21.0101111428240.17363-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

> > umount: none busy - remounted read-only
> 
> > The "none" bit puzzles me the most. /etc/fstab and /etc/mtab
> > look perfectly ok.
> >
> > Has anyone got an idea? Everything worked well with 2.4.0 and
> > Alan's tree up to -ac4, didn't try ac5, and ac6 is what messes
> > up now.
> 
> Try to revert to -ac4 fs/super.c and see if it helps

That makes no difference. Still acting weird. Must be something
else.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
