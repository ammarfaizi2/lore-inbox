Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273877AbRIXMjg>; Mon, 24 Sep 2001 08:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273881AbRIXMjY>; Mon, 24 Sep 2001 08:39:24 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:51472 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273877AbRIXMjL>; Mon, 24 Sep 2001 08:39:11 -0400
Date: Mon, 24 Sep 2001 08:15:57 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrei Lahun <Uman@editec-lotteries.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: process stopped in D state for seconds
In-Reply-To: <20010924152356.A14097@chert.194.133.98.200>
Message-ID: <Pine.LNX.4.21.0109240814070.1593-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Sep 2001, Andrei Lahun wrote:

> with kernel 2.4.10p12-p15 i found that with dvdplayer (xine)
> when i make search in movie one of the thread is stopped in D state for seconds
> (2-10 seconds) after it continue to work.
> with 2.4.10p10(probably also p11) everything is good.
> strace gave me ioctl(0x13,0x5392) so i found that itis in DVD_DO_AUTH
> (in case of DVD_LU_SEND_ASF) so itis call to ide_cdrom_packet.
> Any ideas?

Try to get the task backtrace (dvdplayer in this case) with "Alt+SysRQ+T",
then use ksymoops to decode the trace.

This will probably help the ones who will search for the problem. 

