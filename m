Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280751AbRKKMF1>; Sun, 11 Nov 2001 07:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280895AbRKKMFS>; Sun, 11 Nov 2001 07:05:18 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:32731 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S280751AbRKKMFM>; Sun, 11 Nov 2001 07:05:12 -0500
Date: Sun, 11 Nov 2001 13:05:11 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org,
        ReiserFS Mailingliste <reiserfs-list@namesys.com>
Subject: Re: NFS dropouts with <=2.4.15pre1 + ReiserFS
Message-ID: <20011111130511.A26768@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org,
	ReiserFS Mailingliste <reiserfs-list@namesys.com>
In-Reply-To: <20011111124134.E6421@jensbenecke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011111124134.E6421@jensbenecke.de>; from jens@jensbenecke.de on Sun, Nov 11, 2001 at 12:41:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2001 at 12:41:34PM +0100, Jens Benecke wrote:

> I have two machines, ds9 (workstation) and server (well..), running
> 2.4.15pre1. The server was patched with grsecurity (www.grsecurity.net),
> the workstation was patched with Win4lin (commercial, www.netraverse.com).
(...)
> This seems reproducable with a little effort - so I'd be happy to help
> debugging this (and the bad performance ;) if anybody tells me where to
> start. As I said, with 'echo 9 > nfsd_debug' I got megabytes of logs filled
> with nfsd_dispatch, fh_verify, fh_compose, last message repeated 295 times,
> etc. but nothing that (for me) pointed to an error situation.

First advice is to reproduce this without external patches. 

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
Trilab                                 The Technology People
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
