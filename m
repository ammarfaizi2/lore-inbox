Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262400AbRFNM15>; Thu, 14 Jun 2001 08:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262406AbRFNM1r>; Thu, 14 Jun 2001 08:27:47 -0400
Received: from darkstar.internet-factory.de ([195.122.142.9]:59081 "EHLO
	darkstar.internet-factory.de") by vger.kernel.org with ESMTP
	id <S262400AbRFNM1d>; Thu, 14 Jun 2001 08:27:33 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: Re: bzDisk compression Q; boot debug Q
Date: Thu, 14 Jun 2001 14:27:31 +0200
Organization: Internet Factory AG
Message-ID: <3B28ADB3.7CE09FC3@internet-factory.de>
In-Reply-To: <6B1DF6EEBA51D31182F200902740436802678F59@mail-in.comverse-in.com> <3B2869F9.D0AE17CB@idcomm.com>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 992521652 7000 195.122.142.158 (14 Jun 2001 12:27:32 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 14 Jun 2001 12:27:32 GMT
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac13 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"D. Stimits" proclaimed:
> down to 1.44 MB. But then it would also have to be self-extracting,
> which complicates it, so I'm wondering how effective this current
> compression is, and if a more bzip2-like system would be beneficial as
> kernels get larger?

bzip2 has pretty large memory requirements, consuming up to 8 MB in
addition to the data being uncompressed.
Although thats less of an issue now than it was some years ago, i still
doubt that the kernel is going to be bzip2 compressed any time soon.

if you're looking for better compression, you might want to examine upx
(http://wildsau.idv.uni-linz.ac.at/mfx/upx.html). The kernel image
compression is still experimental, but already usable. kernels tend to
get ~100 K smaller compared to the usual gzip compressed bzImage.

Holger
