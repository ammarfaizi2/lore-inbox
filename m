Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131672AbRC0WS1>; Tue, 27 Mar 2001 17:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131690AbRC0WSS>; Tue, 27 Mar 2001 17:18:18 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:52742 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131672AbRC0WSN>; Tue, 27 Mar 2001 17:18:13 -0500
Message-ID: <3AC11145.58FDCFBB@transmeta.com>
Date: Tue, 27 Mar 2001 14:16:37 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
In-Reply-To: <E14i1ln-0004Tn-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > high-end-disks. Rather the reverse. I'm advocating the SCSI layer not
> > hogging a major number, but letting low-level drivers get at _their_
> > requests directly.
> 
> A major for 'disk' generically makes total sense. Classing raid controllers
> as 'scsi' isnt neccessarily accurate. A major for 'serial ports' would also
> solve a lot of misery
> 

But it might also cause just as much misery, specifically because things
move around too much.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
