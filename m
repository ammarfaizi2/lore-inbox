Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932725AbWBUKQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbWBUKQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 05:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbWBUKQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 05:16:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:16855 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932725AbWBUKQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 05:16:49 -0500
X-Authenticated: #428038
Date: Tue, 21 Feb 2006 11:16:44 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: dhazelton@enter.net, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060221101644.GA19643@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	dhazelton@enter.net, linux-kernel@vger.kernel.org
References: <43EB7BBA.nailIFG412CGY@burner> <200602171502.20268.dhazelton@enter.net> <43F9D771.nail4AL36GWSG@burner> <200602201302.05347.dhazelton@enter.net> <43FAE10F.nailD121QL6LN@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FAE10F.nailD121QL6LN@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-21:

> Try to use my smake to find out whether you use non-portable constructs.
> Smake warns you about the most common problems in makefiles.

To complement this, running Solaris' /usr/{ccs,xpg4}/bin/make and BSD's
portable make (just bootstrap www.pkgsrc.org to obtain "bmake" on Linux)
is probably a much better approach since it tests real-world make
implementations rather than an artificial and not widely available local
flavor.

> > and? The ATA/IDE drivers are more compact that requiring the _entire_ SCSI 
> > transport code and the specific SCSI driver for a device.
> 
> This is an unproven statement.

Proof sketch: Compile Linux without SCSI subsystem and see if
cdrecord dev=/dev/hdc still works.

> It seems that Linux is not used for developing SCSI applications, otherwise
> I would not be the only person complaining about this missing feature.

The other scenario is that nobody but you has problems
developing/porting SCSI applications to Linux, or nobody but you has
problems formulating useful bug reports. Holding on to 1999 bug reports
that you cannot dig up doesn't work without paid support contract,
as you've seen.

-- 
Matthias Andree
