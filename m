Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284779AbRLPTnh>; Sun, 16 Dec 2001 14:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284780AbRLPTnS>; Sun, 16 Dec 2001 14:43:18 -0500
Received: from [213.97.199.90] ([213.97.199.90]:8320 "HELO fargo")
	by vger.kernel.org with SMTP id <S284779AbRLPTm6> convert rfc822-to-8bit;
	Sun, 16 Dec 2001 14:42:58 -0500
From: "David Gomez" <davidge@jazzfree.com>
Date: Sun, 16 Dec 2001 20:42:15 +0100 (CET)
X-X-Sender: <huma@fargo>
To: Momchil Velikov <velco@fadata.bg>
cc: David Gomez <davidge@jazzfree.com>, Dave Jones <davej@suse.de>,
        Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Copying to loop device hangs up everything
In-Reply-To: <87snab85tk.fsf@fadata.bg>
Message-ID: <Pine.LNX.4.33.0112162036370.475-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Dec 2001, Momchil Velikov wrote:

> [...]
>
> David> Thanks ;), this patch solves the problem and copying a lot of data to the
> David> loop device now doesn't hang the computer.
>
> David> Is this patch going to be applied to the stable kernel ? Marcelo ?
>
> I've had exactly the same hangups with or without the patch.

I've tested several times after applying the loop-deadlock patch and the
bug seems to be fixed. No more hangups while copying a lot of data to
loopback devices. Post more info about your hangups, maybe is another
different loop device deadlock.


David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra


