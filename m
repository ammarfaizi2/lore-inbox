Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280433AbRKNKoO>; Wed, 14 Nov 2001 05:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280430AbRKNKoE>; Wed, 14 Nov 2001 05:44:04 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:29194 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S280433AbRKNKns>; Wed, 14 Nov 2001 05:43:48 -0500
Message-ID: <3BF24AB2.1C8232C0@idb.hist.no>
Date: Wed, 14 Nov 2001 11:42:58 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.15-pre1 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reformat mtrr.c to conform to CodingStyle
In-Reply-To: <20011112232539.A14409@redhat.com> <Pine.LNX.4.33.0111130903350.16316-100000@penguin.transmeta.com> <20011114080505.A18098@weta.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:

> If (at some point) people do want coding-style patches then there are
> MANY places (eg. entire filesystem sub-trees) which could have
> white-space alignment changes and similar things....

Creating lots of such patches looks like unnecessary work to me.
Why not let Linus run Lindent on the whole tree and be done with it?
find linux/ -name "*.[ch]" | linux/scripts/Lindent

Helge Hafting
