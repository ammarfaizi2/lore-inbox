Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262496AbRENVKm>; Mon, 14 May 2001 17:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262499AbRENVKc>; Mon, 14 May 2001 17:10:32 -0400
Received: from ns.suse.de ([213.95.15.193]:13066 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262496AbRENVKS>;
	Mon, 14 May 2001 17:10:18 -0400
Date: Mon, 14 May 2001 23:09:54 +0200
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010514230954.A4305@gruyere.muc.suse.de>
In-Reply-To: <3B003EFC.61D9C16A@mandrakesoft.com> <Pine.LNX.4.31.0105141328020.22874-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0105141328020.22874-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, May 14, 2001 at 01:29:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2001 at 01:29:51PM -0700, Linus Torvalds wrote:
> Big device numbers are _not_ a solution. I will accept a 32-bit one, but
> no more, and I will _not_ accept a "manage by hand" approach any more. The
> time has long since come to say "No". Which I've done. If you can't make
> it manage the thing automatically with a script, you won't get a hardcoded
> major device number just because you're lazy.

As far as I can see it just needs a /proc/devices that also outputs
minor ranges with names, and a small program similar to scsidev to 
generate nodes in /dev based on that on the fly on early bootup.

Is that what you have in mind?

-Andi
