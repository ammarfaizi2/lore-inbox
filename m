Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129882AbQKUM4g>; Tue, 21 Nov 2000 07:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130443AbQKUM40>; Tue, 21 Nov 2000 07:56:26 -0500
Received: from ganymede.cdt.luth.se ([130.240.64.41]:62729 "HELO
	ganymede.cdt.luth.se") by vger.kernel.org with SMTP
	id <S129882AbQKUM4T> convert rfc822-to-8bit; Tue, 21 Nov 2000 07:56:19 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Hakan Lennestal <hakanl@cdt.luth.se>
Reply-To: Hakan Lennestal <hakanl@cdt.luth.se>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Andre Hedrick <andre@linux-ide.org>,
        Hakan Lennestal <hakanl@cdt.luth.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0, test10, test11: HPT366 problem 
In-Reply-To: Your message of "Tue, 21 Nov 2000 06:15:11 CST."
             <20001121061511.F2918@wire.cadcamlab.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Date: Tue, 21 Nov 2000 13:26:17 +0100
Message-Id: <20001121122617.88D1A26@ganymede.cdt.luth.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20001121061511.F2918@wire.cadcamlab.org>, Peter Samuelson writes:

> The way I understood Hakan was: "it boots in udma4, and if it gets all
> the way to userland I immediately hdparm it down to udma3, and then it
> works fine".
> 
> Hakan, is this what you meant?  If so, forcing it <= udma3 should be ok.

Yes.

When it comes to the partition detection during bootup, udma4 or udma3
doesn't seem to matter. It passes approx. one out of ten times either
way. When the system is up and running, using udma4 seem to hang the
system sooner or later. Udma3 on the other hand seem to be quite stable.

/Håkan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
