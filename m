Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267977AbRGZOGD>; Thu, 26 Jul 2001 10:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267988AbRGZOFx>; Thu, 26 Jul 2001 10:05:53 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:24068 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S267977AbRGZOFg>; Thu, 26 Jul 2001 10:05:36 -0400
Message-ID: <3B602531.2DD2D573@zip.com.au>
Date: Fri, 27 Jul 2001 00:12:01 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <E15PlYr-0003mr-00@the-village.bc.nu> <Pine.LNX.4.33L.0107261054070.20326-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Rik van Riel wrote:
> 
> 
> Furthermore, even the journaling filesystems won't all guarantee that
> the various parts of a rename() operation will all be in the same
> transaction.

umm..  I'd certainly hope that they do guarantee this.

The only operations which can't trivially fit into a single
transaction are write() and truncate().
 
-
