Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263212AbSJHOZ5>; Tue, 8 Oct 2002 10:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263213AbSJHOZ4>; Tue, 8 Oct 2002 10:25:56 -0400
Received: from [217.144.230.27] ([217.144.230.27]:53517 "HELO
	lexx.infeline.org") by vger.kernel.org with SMTP id <S263212AbSJHOZ4>;
	Tue, 8 Oct 2002 10:25:56 -0400
Date: Tue, 8 Oct 2002 16:31:33 +0200 (CEST)
From: Ketil Froyn <ketil-kernel@froyn.net>
X-X-Sender: ketil@ketil.np
To: "jbradford@dial.pipex.com" <jbradford@dial.pipex.com>
cc: Alexander Viro <viro@math.psu.edu>,
       "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
       "mochel@osdl.org" <mochel@osdl.org>,
       "torvalds@transmeta.com" <torvalds@transmeta.com>,
       "andre@linux-ide.org" <andre@linux-ide.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IDE driver model update
In-Reply-To: <200210081325.g98DP6MY000340@darkstar.example.net>
Message-ID: <Pine.LNX.4.40L0.0210081627480.1519-100000@ketil.np>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, jbradford@dial.pipex.com wrote:

> This raises the interesting possibility of being able to refer to
> things like removable media directly, instead of the device the media
> is inserted in.
>
> The Amiga was doing this years ago.  You could access floppy drives
> as, E.G. df0:, df1:, etc, but if you formatted a volume and called it
> foobar, you could access foobar: no matter which floppy drive you put
> it in to.

Isn't this possible in /etc/fstab already? Standard redhat-installs seem
to put in the labels of the volume instead of referring to the device.

> Also, Plan 9 does similar interesting things - you can do the
> equivilent of:
>
> ls /internet/websites/kernel.org/
>
> and treat the website as a filesystem.

Wouldn't you just need a filesystem driver for this? I don't know that
it's a good idea, though ;)

Ketil

