Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289395AbSAVUQf>; Tue, 22 Jan 2002 15:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289381AbSAVUQZ>; Tue, 22 Jan 2002 15:16:25 -0500
Received: from mail.cert.uni-stuttgart.de ([129.69.16.17]:43955 "HELO
	Mail.CERT.Uni-Stuttgart.DE") by vger.kernel.org with SMTP
	id <S289386AbSAVUQQ>; Tue, 22 Jan 2002 15:16:16 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon PSE/AGP Bug
In-Reply-To: <1011610422.13864.24.camel@zeus>
	<20020121.053724.124970557.davem@redhat.com>
	<20020121.053724.124970557.davem@redhat.com>
	<20020121175410.G8292@athlon.random> <3C4C5B26.3A8512EF@zip.com.au>
	<o7cp4ukpr9ehftpos1hg807a9hfor7s55e@4ax.com>
	<hbep4uka8q6t1tfv6694sjtvfrulipg3a4@4ax.com>
From: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Date: Tue, 22 Jan 2002 21:13:42 +0100
In-Reply-To: <hbep4uka8q6t1tfv6694sjtvfrulipg3a4@4ax.com> (Steve
 Brueggeman's message of "Mon, 21 Jan 2002 19:02:39 -0600")
Message-ID: <87k7uakutl.fsf@CERT.Uni-Stuttgart.DE>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Brueggeman <brewgyman@mediaone.net> writes:

> Forgot to mention, I got the segfaults compiling kernels while running
> linux-2.4.17, I was in console, and did not have Frame Buffer, or drm drivers
> loaded.  I did have the SiS AGP compiled into the kernel though.

On my new system at home, I got similar segfaults.  Running memtest86
revealed that one of the RAM modules had a problem--and if I swapped
them, the BIOS startup code wouldn't even expand the actual BIOS code
every other system boot.  After removing the offending RAM module (and
later replacing it) the problems were completely gone and haven't
returned yet...

Fortunately, I didn't know of the PSE/AGP bug back then.  This made
debugging much, much easier. ;-)

-- 
Florian Weimer 	                  Weimer@CERT.Uni-Stuttgart.DE
University of Stuttgart           http://CERT.Uni-Stuttgart.DE/people/fw/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
