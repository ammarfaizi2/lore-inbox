Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131718AbRC1AJo>; Tue, 27 Mar 2001 19:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131728AbRC1AJe>; Tue, 27 Mar 2001 19:09:34 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:37900 "EHLO neon-gw.transmeta.com") by vger.kernel.org with ESMTP id <S131718AbRC1AJS>; Tue, 27 Mar 2001 19:09:18 -0500
Date: Tue, 27 Mar 2001 16:07:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "H. Peter Anvin" <hpa@transmeta.com>, <Andries.Brouwer@cwi.nl>, <linux-kernel@vger.kernel.org>, <tytso@MIT.EDU>
Subject: Re: Larger dev_t
In-Reply-To: <E14i1ln-0004Tn-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0103271606420.25282-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Mar 2001, Alan Cox wrote:
>
> A major for 'disk' generically makes total sense. Classing raid controllers
> as 'scsi' isnt neccessarily accurate. A major for 'serial ports' would also
> solve a lot of misery

Exactly. It's just that for historical reasons, I think the major for
"disk" should be either the old IDE or SCSI one, which just can show more
devices. That way old installers etc work without having to suddenly start
knowing about /dev/disk0.

But hey, maybe I'm wrong.

		Linus

