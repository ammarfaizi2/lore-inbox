Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbWBVRaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWBVRaz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWBVRaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:30:55 -0500
Received: from mail.gmx.de ([213.165.64.20]:61923 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030318AbWBVRaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:30:55 -0500
X-Authenticated: #428038
Date: Wed, 22 Feb 2006 18:30:51 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060222173051.GF19733@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org
References: <43EB7BBA.nailIFG412CGY@burner> <200602201302.05347.dhazelton@enter.net> <43FAE10F.nailD121QL6LN@burner> <200602211837.37211.dhazelton@enter.net> <43FC9B9C.nailEC7612T9Q@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FC9B9C.nailEC7612T9Q@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-22:

> "D. Hazelton" <dhazelton@enter.net> wrote:

> > similar to the old ide-scsi module, that sits on top of the SCSI and ATA 
> > interfaces and provides the capacity to access any disk device on the system 
> > using SCSI commands.
> 
> If this is a ide-scsi replacement, everything would be fine.

That doesn't matter: your policy is to support older kernels, and by the
time it will become available there will still be 2.6.13, .14, .15
kernels around that don't have SAT, so you will need to have code that
works well with 2.6.15 anyhow if you are to comply with your own
intentions.

-- 
Matthias Andree
