Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277755AbRJLQ1H>; Fri, 12 Oct 2001 12:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277750AbRJLQ06>; Fri, 12 Oct 2001 12:26:58 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:505 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S277755AbRJLQ0u>; Fri, 12 Oct 2001 12:26:50 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 12 Oct 2001 10:27:03 -0600
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, Matt Domsch <mdomsch@Dell.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EFI GUID Partition Tables
Message-ID: <20011012102703.Q8382@turbolinux.com>
Mail-Followup-To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
	Richard Gooch <rgooch@ras.ucalgary.ca>,
	Matt Domsch <mdomsch@Dell.com>,
	Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200110091725.f99HPZ530405@vindaloo.ras.ucalgary.ca> <Pine.LNX.4.33.0110121026430.9327-100000@biker.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110121026430.9327-100000@biker.pdb.fsc.net>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 12, 2001  10:31 +0200, Martin Wilck wrote:
> Richard,
> > You've put the devfs_unregister_slave() inside an #ifdef. Yuk! It
> > shouldn't be conditional.
> 
> I did that because I didn't want to pollute your code. The function
> was only needed for the UUID patch.

What would be more fitting is to put the actual declaration of
devfs_unregister_slave() inside the #ifdef, and otherwise have an
empty function which does nothing.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

