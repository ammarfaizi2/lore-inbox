Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262623AbSJGTRN>; Mon, 7 Oct 2002 15:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262624AbSJGTRN>; Mon, 7 Oct 2002 15:17:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61701 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262623AbSJGTRM> convert rfc822-to-8bit; Mon, 7 Oct 2002 15:17:12 -0400
Date: Mon, 7 Oct 2002 12:22:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.41
In-Reply-To: <Pine.LNX.4.33.0210071157270.1917-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0210071217380.10143-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g97JMmA16698
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Oct 2002, Linus Torvalds wrote:
> 
> Tons of stuff. Mucho merges with the "A-Team" (Alan, Al, Alexey, Andrew,
> Anton, Arjan, Arnaldo and Art), but the "M-Team" (Maksim, Marcel, Martin's
> and Mike) is a close runner up. The J's are doing well too.

Oh, and I totally forgot .. 

The merge from Andrew merged in various VM counter updates, which change 
/proc accounting in ways that make some of the system monitoring stuff 
unhappy. In particular, you'll find "vmstat" dumping core, and "top" has a 
few glitches too.

You can fix all of this by just upgrading to a newer "procps" package. Rik 
maintains a procps-2.0.9 (many of the stats were his) at

	http://surriel.com/procps/

I don't think there are ready-made binary packages, but maybe some
enterprising and helpful - and trustworthy - soul can do that and get
vendors to add it to their upgrade list (or at least make it available in
contrib).

		Linus

