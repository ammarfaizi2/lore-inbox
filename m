Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWA3RtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWA3RtU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWA3RtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:49:20 -0500
Received: from mail.gmx.net ([213.165.64.21]:29316 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964842AbWA3RtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:49:19 -0500
X-Authenticated: #428038
Date: Mon, 30 Jan 2006 18:49:13 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, bzolnier@gmail.com, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]
Message-ID: <20060130174913.GA11430@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
	jengelh@linux01.gwdg.de, bzolnier@gmail.com, acahalan@gmail.com
References: <Pine.LNX.4.61.0601292139080.2596@yvahk01.tjqt.qr> <43DD2A8A.nailGVQ115GOP@burner> <787b0d920601291328k52191977h3778a7c833d640f2@mail.gmail.com> <43DE3A99.nail16ZK1MAWN@burner> <787b0d920601300831j99fae82n5d4a5d94f99baafd@mail.gmail.com> <43DE405D.nail2AM2BPF20@burner> <20060130170813.GG19173@merlin.emma.line.org> <43DE495A.nail2BR211K0O@burner> <20060130173028.GA5452@merlin.emma.line.org> <43DE4EC3.nail2D51I6BPD@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DE4EC3.nail2D51I6BPD@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-01-30:

> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> > Joerg Schilling schrieb am 2006-01-30:
> >
> > > Let me ask again:
> > > 
> > > 	Is there a way to get (or construct) a closed view on the namespace 
> > > 	for all SCSI devices?
> >
> > Of course there is, /dev/sg*.
> >
> > But that is not what you're _actually_ asking - you appear to desire a
> > unified namespace for SCSI + ATAPI + whatever, and the answer to that
> > was /dev/*.
> 
> I am only asking for a unique name space for all devices that talk SCSI.

That is not the same.

> And please: read the SCSI Standard on t10.org to learn that ATA is just one
> of many possible SCSI transports.

The t10.org front page mentions ATAPI links, and the links section leads
to t13.org for ATAPI. And now?

Besides that, Linux is not currently implemented to make everybody and
their dog look like SPI with ID, LUN and everything, and until now you
have not presented anything but phantoms (such as ATAPI tapes) to
support your point why it should do that. No wonder people are losing
interest in the discussion if you don't even answer questions what the
current Linux interface don't give you, and you haven't seriously
responded to my suggestion to simply scan all transports in libscg, for
instance, "" (sg+pg), ATA:, ATAPI, RSCSI:.

-- 
Matthias Andree
