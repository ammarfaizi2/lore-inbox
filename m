Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130384AbQKGAUG>; Mon, 6 Nov 2000 19:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130137AbQKGAT6>; Mon, 6 Nov 2000 19:19:58 -0500
Received: from navy.csi.cam.ac.uk ([131.111.8.49]:65198 "EHLO
	navy.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129634AbQKGATm>; Mon, 6 Nov 2000 19:19:42 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: Dan Hollis <goemon@anime.net>
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Date: Tue, 7 Nov 2000 00:18:00 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011061054080.23388-100000@anime.net>
In-Reply-To: <Pine.LNX.4.21.0011061054080.23388-100000@anime.net>
MIME-Version: 1.0
Message-Id: <00110700192100.00940@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2000, Dan Hollis wrote:
> On Mon, 6 Nov 2000, James A. Sutherland wrote:
> > So autoload the module with a "dont_screw_with_mixer" option. When the kernel
> > first boots, initialise the mixer to suitable settings (load the module with 
> > "do_screw_with_mixer" or whatever); thereafter, the driver shouldn't change
> > the mixer settings on load.
> 
> You are asking for real trouble on hotplug hardware if you insist on this.

How so? There is no need for the driver to decide off its own bat to go
changing settings. If I plug in a hotplug soundcard and load the driver, I do
NOT want the driver to decide to set some settings. If I want settings set,
I'll do it myself (or have a script to do it).


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
