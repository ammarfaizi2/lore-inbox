Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273622AbRK1QoC>; Wed, 28 Nov 2001 11:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273213AbRK1Qnw>; Wed, 28 Nov 2001 11:43:52 -0500
Received: from ns.caldera.de ([212.34.180.1]:2531 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S273305AbRK1Qnd>;
	Wed, 28 Nov 2001 11:43:33 -0500
Date: Wed, 28 Nov 2001 17:42:50 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre2 does not compile
Message-ID: <20011128174250.A17582@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Andreas Dilger <adilger@turbolabs.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200111272209.fARM9tk18991@ns.caldera.de> <Pine.LNX.4.33.0111271628430.1629-100000@penguin.transmeta.com> <20011128135508.A21418@caldera.de> <20011128092600.Q730@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011128092600.Q730@lynx.no>; from adilger@turbolabs.com on Wed, Nov 28, 2001 at 09:26:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2001 at 09:26:00AM -0700, Andreas Dilger wrote:
> What would be nice in the case of drivers that don't use the new error
> handling code is to add something like:
> 
> #warning "Uses obsolete SCSI error code, see Documentation/2.5/scsi-error.txt"
> 
> for a hint as to the reason why it no longer compiles, and a short guide
> on how to update the drivers.

I already thought about that - as the old error handling code is selected
by setting a member in a struct to '1' I don't see any easy way to do so...

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
