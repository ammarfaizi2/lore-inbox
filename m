Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbRF1NIX>; Thu, 28 Jun 2001 09:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265709AbRF1NIN>; Thu, 28 Jun 2001 09:08:13 -0400
Received: from m1002-mp1-cvx1c.col.ntl.com ([213.104.79.234]:20352 "EHLO
	[213.104.79.234]") by vger.kernel.org with ESMTP id <S265706AbRF1NIC>;
	Thu, 28 Jun 2001 09:08:02 -0400
To: Stefan Hoffmeister <lkml."2001"@econos.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <15160.65442.682067.38776@gargle.gargle.HOWL>
	<Pine.LNX.4.33L.0106261838320.23373-100000@duckman.distro.conectiva>
	<qn1ijt06guu1014p6om26opk7k5933kb7i@4ax.com>
From: John Fremlin <vii@users.sourceforge.net>
Date: 28 Jun 2001 14:07:16 +0100
In-Reply-To: <qn1ijt06guu1014p6om26opk7k5933kb7i@4ax.com> (Stefan Hoffmeister's message of "Wed, 27 Jun 2001 00:21:09 +0200")
Message-ID: <m2wv5whhx7.fsf@boreas.yi.org.>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Stefan Hoffmeister <lkml.2001@econos.de> writes:

[...]

> Windows NT/2000 has flags that can be for each CreateFile operation
> ("open" in Unix terms), for instance
> 
>   FILE_ATTRIBUTE_TEMPORARY
> 
>   FILE_FLAG_WRITE_THROUGH
>   FILE_FLAG_NO_BUFFERING
>   FILE_FLAG_RANDOM_ACCESS
>   FILE_FLAG_SEQUENTIAL_SCAN
> 
> If Linux does not have mechanism that would allow the signalling of
> specific use case, it might be helpful to implement such a hinting
> system?

madvise(2) does it on mappings IIRC

-- 
Seeking summer job at last minute - see http://ape.n3.net/cv.html
