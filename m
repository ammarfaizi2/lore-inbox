Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLOUft>; Fri, 15 Dec 2000 15:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQLOUfj>; Fri, 15 Dec 2000 15:35:39 -0500
Received: from moot.mb.ca ([64.4.83.10]:17163 "EHLO moot.cdir.mb.ca")
	by vger.kernel.org with ESMTP id <S129228AbQLOUf3>;
	Fri, 15 Dec 2000 15:35:29 -0500
Date: Fri, 15 Dec 2000 14:04:43 -0600 (CST)
From: "Michael J. Dikkema" <mjd@moot.ca>
To: Matt Bernstein <matt@theBachChoir.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: BOOTP (and DHCP) not working in 2.2.18?
In-Reply-To: <Pine.LNX.4.30.0012151216020.895-100000@r2-pc>
Message-ID: <Pine.LNX.4.21.0012151403270.15044-100000@sliver.moot.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2000, Matt Bernstein wrote:

> In the file net/ipv4/ipconfig.c is a variable called ic_enabled which is
> initialised to zero and never set anywhere. a check is made and bootp
> isn't run if its not set. Setting it to 1 before the check makes it appear
> to work.

If I change the ic_enable variable to a 1 from 0, my DHCP starts working
again. I'll come up with a more sane patch for 2.2.18 today or
tomorrow. (unless someone else does it first)

,.;::
: Michael J. Dikkema
| Systems / Network Admin - Internet Solutions, Inc.
| http://www.moot.ca   Work: (204) 982-1060
; mjd@moot.ca
',.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
