Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131826AbQKKANL>; Fri, 10 Nov 2000 19:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131815AbQKKANB>; Fri, 10 Nov 2000 19:13:01 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:45200 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S131610AbQKKAMl>;
	Fri, 10 Nov 2000 19:12:41 -0500
Date: Fri, 10 Nov 2000 19:12:29 -0500
Message-Id: <200011110012.TAA22015@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: "Matt D. Robinson" <yakker@alacritech.com>
CC: Christoph Rohland <cr@sap.com>, "Theodore Y. Ts'o" <tytso@MIT.EDU>,
        richardj_moore@uk.ibm.com, Paul Jakma <paulj@itg.ie>,
        Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
In-Reply-To: Matt D. Robinson's message of Fri, 10 Nov 2000 10:36:31 -0800,
	<3A0C402F.8F0BA261@alacritech.com>
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Fri, 10 Nov 2000 10:36:31 -0800
   From: "Matt D. Robinson" <yakker@alacritech.com>

   As soon as I finish writing raw write disk routines (not using kiobufs),
   we can _maybe_ get LKCD accepted one of these days, especially now that we
   don't have to build 'lcrash' against a kernel revision.  I'm in the
   middle of putting together raw IDE functions now -- see LKCD mailing
   list for details if you're curious.

Great!  Are you thinking about putting the crash dumper and the raw
write disk routines in a separate text section, so they can be located
in pages which are write-protected from accidental modification in case
some kernel code goes wild?  (Who me?  Paranoid?  :-)

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
