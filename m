Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130137AbRBJBix>; Fri, 9 Feb 2001 20:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130892AbRBJBin>; Fri, 9 Feb 2001 20:38:43 -0500
Received: from [216.151.155.116] ([216.151.155.116]:48391 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S130137AbRBJBii>; Fri, 9 Feb 2001 20:38:38 -0500
To: "David L. Nicol" <dnicol@cstp.umkc.edu>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Miller, Brendan" <Brendan.Miller@Dialogic.com>
Subject: Re: bidirectional named pipe?
In-Reply-To: <E14OxTz-0007yS-00@the-village.bc.nu>
	<3A81D5B4.9CBC9B0D@kasey.umkc.edu> <3A848BFF.C7C0E258@cstp.umkc.edu>
From: Doug McNaught <doug@wireboard.com>
Date: 09 Feb 2001 20:37:44 -0500
In-Reply-To: "David L. Nicol"'s message of "Fri, 09 Feb 2001 18:31:59 -0600"
Message-ID: <m3vgqjz5av.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David L. Nicol" <dnicol@cstp.umkc.edu> writes:

> According to the Understanding the Linux Kernel book I
> plowed through yesterday afternoon the EXT2 file system
> has a defined file type "socket," distinct from fifo.
> 
> How does one set up a named socket in a file system?  Is it
> a legacy constant that has never been supported or what?
> 

Call bind() on an AF_LOCAL (aka AF_UNIX) socket. 

About as far from legacy as you can get...

-Doug
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
