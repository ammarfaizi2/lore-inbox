Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271924AbRH3QyD>; Thu, 30 Aug 2001 12:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271986AbRH3Qxy>; Thu, 30 Aug 2001 12:53:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53771 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271924AbRH3Qxo>; Thu, 30 Aug 2001 12:53:44 -0400
Date: Thu, 30 Aug 2001 09:50:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christopher Friesen <cfriesen@nortelnetworks.com>
cc: Roman Zippel <zippel@linux-m68k.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        David Lang <david.lang@digitalinsight.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <3B8E6CA3.6F5F6735@nortelnetworks.com>
Message-ID: <Pine.LNX.4.33.0108300949080.8027-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 30 Aug 2001, Christopher Friesen wrote:
>
> Wouldn't it have made more sense to make the 'len' parameter an unsigned int?

Oh yes.

And wouldn't it be nicer if the sky was pink, and God came personally down
to earth and stopped all wrans and made you king?

You do realize that many things are signed, whether you want them to be or
not?

Like "off_t", which on the face of it sounds like it should be unsigned
("offset within a file - oh, that can obviously never be negative").

		Linus

