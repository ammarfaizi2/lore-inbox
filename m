Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbQKQO1h>; Fri, 17 Nov 2000 09:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129203AbQKQO11>; Fri, 17 Nov 2000 09:27:27 -0500
Received: from Cantor.suse.de ([194.112.123.193]:42510 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129092AbQKQO1X>;
	Fri, 17 Nov 2000 09:27:23 -0500
Date: Fri, 17 Nov 2000 14:54:36 +0100
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andi Kleen <ak@suse.de>, Christoph Rohland <cr@sap.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Tigran Aivazian <tigran@veritas.com>,
        Mikael Pettersson <mikpe@csd.uu.se>, Jordan <ledzep37@home.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Error in x86 CPU capabilities starting with test5/6
Message-ID: <20001117145436.A7555@gruyere.muc.suse.de>
In-Reply-To: <E13wkLK-0000bP-00@the-village.bc.nu> <qwwpujuvk1s.fsf@sap.com> <3A152DC1.21B35324@mandrakesoft.com> <qwwlmuivio0.fsf@sap.com> <20001117143150.A6832@gruyere.muc.suse.de> <3A15354B.4736A19@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A15354B.4736A19@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Nov 17, 2000 at 08:40:27AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 08:40:27AM -0500, Jeff Garzik wrote:
> Andi Kleen wrote:
> > No it would not. Often you want cycle accurate couting for profiling
> > purposes.
> 
> Isn't that why /dev/cpu/%d/msr exists?

Requires either root privileges or is a big security hole.

[of course rdtsc only works properly on UP or with bind_cpu()]
-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
