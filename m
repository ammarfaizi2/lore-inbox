Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288828AbSAFW1a>; Sun, 6 Jan 2002 17:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287573AbSAFW1V>; Sun, 6 Jan 2002 17:27:21 -0500
Received: from dialin-145-254-148-160.arcor-ip.net ([145.254.148.160]:28164
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S282967AbSAFW1I>; Sun, 6 Jan 2002 17:27:08 -0500
Message-ID: <3C38CD88.95284629@loewe-komp.de>
Date: Sun, 06 Jan 2002 23:19:52 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jorge Nerin <comandante@zaralinux.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-smp <linux-smp@vger.kernel.org>
Subject: Re: xmms child blocked at end (2.4.18pre1)
In-Reply-To: <3C388442.102@zaralinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jorge Nerin schrieb:
> 
> Hello, I have a very strange thing here.
> 
> I have a 2x200mmx using 2.4.18pre1, xmms 1.2.5, xawtv-3.61 and XFree86
> Version 4.1.0.
> 
> The situation is that I have a nfs mounted share with mp3, using xmms to
> play them, (3c503 over coax) everithing goes well until I put xawtv in
> fullscreen mode. I don't know why, but at this time in short time the
> child thread of xmms blocks for a long time in end, having xawtv in a
> window does not cause this.
> 
> Here is a vmstat 1 log:
[snip] 
> The only blocked task is xmms child, as I said it's blocked in end, so
> it empties it's buffer and you can hear it
> 
> Another thing I have noticed is that when I have a big transfer with
> this card (I have another 3c595) and having xawtv in full screen I can
> see dropped frames, I assume this is for the speed downgrade of the pci
> bus to acomodate isa tranfers, the 3c503 is a very old isa nic, and my
> tv capture is a pci bt848.
> 

"end" is the name, because the address is bigger than any known symbol.
I think it has something to do with pthread in general - since I observed
it several times with  threaded apps (not only xmms)
