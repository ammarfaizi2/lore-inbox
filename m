Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264028AbRFNUn7>; Thu, 14 Jun 2001 16:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264038AbRFNUnu>; Thu, 14 Jun 2001 16:43:50 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:37252 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S264028AbRFNUnb>; Thu, 14 Jun 2001 16:43:31 -0400
Message-ID: <3B292235.D81F3637@idcomm.com>
Date: Thu, 14 Jun 2001 14:44:37 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: bzDisk compression Q; boot debug Q
In-Reply-To: <6B1DF6EEBA51D31182F200902740436802678F59@mail-in.comverse-in.com> <3B2869F9.D0AE17CB@idcomm.com> <3B28ADB3.7CE09FC3@internet-factory.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holger Lubitz wrote:
> 
> "D. Stimits" proclaimed:
> > down to 1.44 MB. But then it would also have to be self-extracting,
> > which complicates it, so I'm wondering how effective this current
> > compression is, and if a more bzip2-like system would be beneficial as
> > kernels get larger?
> 
> bzip2 has pretty large memory requirements, consuming up to 8 MB in
> addition to the data being uncompressed.
> Although thats less of an issue now than it was some years ago, i still
> doubt that the kernel is going to be bzip2 compressed any time soon.
> 
> if you're looking for better compression, you might want to examine upx
> (http://wildsau.idv.uni-linz.ac.at/mfx/upx.html). The kernel image
> compression is still experimental, but already usable. kernels tend to
> get ~100 K smaller compared to the usual gzip compressed bzImage.

Interesting stuff...and the license is non-commercial as well.

D. Stimits, stimits@idcomm.com

> 
> Holger
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
