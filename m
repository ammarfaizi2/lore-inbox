Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287373AbSAUQcw>; Mon, 21 Jan 2002 11:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287359AbSAUQcm>; Mon, 21 Jan 2002 11:32:42 -0500
Received: from ns.suse.de ([213.95.15.193]:60430 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287348AbSAUQcd>;
	Mon, 21 Jan 2002 11:32:33 -0500
Date: Mon, 21 Jan 2002 17:32:32 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, <martin.macok@underground.cz>,
        <linux-kernel@vger.kernel.org>, <ak@muc.de>
Subject: Re: [andrewg@tasmail.com: remote memory reading through tcp/icmp]
In-Reply-To: <20020121141436.A11489@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0201211729160.5384-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Russell King wrote:

> 127.0.0.1 sent an invalid ICMP error to a broadcast.
> from the ipv4 stack after fixing these as per the Andi's patch.  I'm not
> certain what's causing it; it only happens while the box is coming up.

Further investigation showed that 2.5.2-pre2 + andi's fix + a minimal
set of compile fixes made my problem disappear. Looks like a bad
interaction between something I had in -dj already, and the pre2 merge.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

