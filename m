Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbTEMF1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 01:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbTEMF1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 01:27:22 -0400
Received: from [195.95.38.160] ([195.95.38.160]:56304 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S263012AbTEMF1U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 01:27:20 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       Torrey Hoffman <thoffman@arnor.net>
Subject: Re: [2.420] Unexplained repeatable Oops
Date: Tue, 13 May 2003 07:40:38 +0200
User-Agent: KMail/1.5.1
References: <200305112052.51938.devilkin-lkml@blindguardian.org> <200305120739.30154.kernel@kolivas.org>
In-Reply-To: <200305120739.30154.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305130740.45250.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 11 May 2003 23:39, Con Kolivas wrote:
> On Mon, 12 May 2003 04:52, DevilKin-LKML wrote:
> > On my main machine at home I have encountered since this morning an Oops
> > that never happened before. It happened when I was playing a game of
> > Diablo II through Winex (yes, with the Nvidia modules loaded and stuff
> > loaded from VMWare). This oops I didn't bother to capture, since I know
> > that oops'es from a tainted kernel are not accepted.
> > 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
> > (rev 40) Subsystem: ABIT Computer Corp.: Unknown device a702
> >         Flags: bus master, stepping, medium devsel, latency 0
> >         Capabilities: [c0] Power Management version 2
>
> Good old VIA chipset. I solved a similar problem by underclocking a cpu on
> a similar chipset :-(
>
> Try the mprime client stress test to ensure your hardware is ok.
> www.mersenne.org

I wasn't able to get this thing working, so I tried cpuburn and seti@home 
instead. Both ran my cpu up to around 70 degrees C, and everything was still 
working perfectly.

All fans were spinning nicely along, including the vidcard fan.

After this, I let things cool down, ran winex+diablo2 and the system crashed 
in under 20 minutes.

To make sure it wasn't hardware related I ran 3dMark 2003 under windows and 
well... it resulted in a blue screen after 10 minutes of running this quite 
intensive test. So I suppose something is wrong with my AGP card.

Strange thing is that I actually get crashes, and not video problems as I 
would expect...

I've already tried turning of AGP Fast Writes, and have tuned down the AGP 
write speed from 4x to 2x (lowest I can put it).

Any other ideas?

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+wIVYpuyeqyCEh60RAmkYAJ0cKXL7nmV/GTDlmSPhruQMtZ139QCghEv4
3GhwEj0MZ7R2rqN0UYo+hY0=
=7rEr
-----END PGP SIGNATURE-----

