Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbQKFS4L>; Mon, 6 Nov 2000 13:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129850AbQKFS4B>; Mon, 6 Nov 2000 13:56:01 -0500
Received: from anime.net ([63.172.78.150]:26122 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S129387AbQKFSz6>;
	Mon, 6 Nov 2000 13:55:58 -0500
Date: Mon, 6 Nov 2000 10:55:49 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: "James A. Sutherland" <jas88@cam.ac.uk>
cc: David Woodhouse <dwmw2@infradead.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <00110613370501.01541@dax.joh.cam.ac.uk>
Message-ID: <Pine.LNX.4.21.0011061054080.23388-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, James A. Sutherland wrote:
> So autoload the module with a "dont_screw_with_mixer" option. When the kernel
> first boots, initialise the mixer to suitable settings (load the module with 
> "do_screw_with_mixer" or whatever); thereafter, the driver shouldn't change
> the mixer settings on load.

You are asking for real trouble on hotplug hardware if you insist on this.

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
