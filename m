Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131004AbQJ1Xcv>; Sat, 28 Oct 2000 19:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131334AbQJ1Xcl>; Sat, 28 Oct 2000 19:32:41 -0400
Received: from [63.89.188.10] ([63.89.188.10]:48402 "EHLO xchange.zambeel.com")
	by vger.kernel.org with ESMTP id <S131004AbQJ1Xcc>;
	Sat, 28 Oct 2000 19:32:32 -0400
From: Michael Eisler <mre@Zambeel.com>
Reply-To: Michael Eisler <mre@Zambeel.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Tony.Lill@ajlc.waterloo.on.ca, nfs-devel@linux.kernel.org,
        linux-kernel@vger.kernel.org
Date: Sat, 28 Oct 2000 16:29:50 -0700 (PDT)
Subject: Re: OOPS in nfsd, affects all 2.2 and 2.4 kernels
In-Reply-To: "Your message with ID" <14842.26381.840222.185953@notabene.cse.unsw.edu.au>
Message-ID: <Roam.SIMC.2.0.6.972775790.15154.mre@zambeel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This problem that you are addressing is caused when solaris sends a
> zero length write (I assume to implement the "access" system call, but
> I haven't checked).

more likely a long standing bug in Solaris that hasn't been stomped.

Tony, you might let Sun know that you have a way to reproduce it at
will, though there are Sun people on this alias who I'm sure will
make it a high priority to stomp this one. :-)

	-mre 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
