Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129488AbQKBHlc>; Thu, 2 Nov 2000 02:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129545AbQKBHlV>; Thu, 2 Nov 2000 02:41:21 -0500
Received: from styx.suse.cz ([195.70.145.226]:45553 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129488AbQKBHlG>;
	Thu, 2 Nov 2000 02:41:06 -0500
Date: Thu, 2 Nov 2000 08:40:52 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: TimO <hairballmt@mcn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-via@gtf.org
Subject: Re: Announce: Via audio driver update
Message-ID: <20001102084052.A862@suse.cz>
In-Reply-To: <39E54117.37461BD1@mandrakesoft.com> <3A00F17B.1E7537FA@mcn.net> <3A00F515.45D67F1C@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A00F515.45D67F1C@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Nov 02, 2000 at 12:01:09AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2000 at 12:01:09AM -0500, Jeff Garzik wrote:

> Please grab 1.1.14, there were a number of bug fixes since 1.1.10.  You
> can get this version in the recently-released 2.4.0-test10 kernel, or
> download from http://sourceforge.net/projects/gkernel/

Hi!

I'd like to report a bug, too. On my system, with the test10 kernel,
regardless of what frequency the software sets, the data is always
played at 48 KHz.

Via 686a audio driver 1.1.14
ac97_codec: AC97 Audio codec, id: 0x574d:0x4c00 (Wolfson WM9704)
via82cxxx: board #1 at 0xDC00, IRQ 10

The codec doesn't support variable rate input, as far as I know. Could
that be the cause?

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
