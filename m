Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSCRWsk>; Mon, 18 Mar 2002 17:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293190AbSCRWsb>; Mon, 18 Mar 2002 17:48:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59409 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293203AbSCRWsX> convert rfc822-to-8bit; Mon, 18 Mar 2002 17:48:23 -0500
Date: Mon, 18 Mar 2002 14:46:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 7.52 second kernel compile
In-Reply-To: <200203182312.24958.Dieter.Nuetzel@hamburg.de>
Message-ID: <Pine.LNX.4.33.0203181434440.10517-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g2IMlpN00447
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Mar 2002, Dieter [iso-8859-15] Nützel wrote:
>
> it seems to be that it depends on gcc and flags.

That instability doesn't seem to show up on a PII. Interesting. Looks like 
the athlon may be reordering TLB accesses, while the PII apparently 
doesn't.

Or maybe the program is just flawed, and the interesting 1/8 pattern comes 
from something else altogether.

			Linus

