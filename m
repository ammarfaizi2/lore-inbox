Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264169AbRF0VDv>; Wed, 27 Jun 2001 17:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265398AbRF0VDl>; Wed, 27 Jun 2001 17:03:41 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:62728 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264169AbRF0VDY>; Wed, 27 Jun 2001 17:03:24 -0400
Message-ID: <3B3A4A09.F7D8D5BA@transmeta.com>
Date: Wed, 27 Jun 2001 14:03:05 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] User chroot
In-Reply-To: <200106272055.f5RKtur331470@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:
> 
> BTW, it is way wrong that /dev/zero should be needed at all.
> Such use is undocumented ("man zero", "man mmap") anyway, and
> AFAIK one should use mmap() with MAP_ANON instead. Not that
> the documentation on MAP_ANON is any good either, but at least
> the mere existence of the flag is mentioned.
> 

RTFM(POSIX).

	-hpa
