Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277581AbRJLIaz>; Fri, 12 Oct 2001 04:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277585AbRJLIaq>; Fri, 12 Oct 2001 04:30:46 -0400
Received: from energy.pdb.sbs.de ([192.109.2.19]:36837 "EHLO nixpbe.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S277581AbRJLIai>;
	Fri, 12 Oct 2001 04:30:38 -0400
Date: Fri, 12 Oct 2001 10:31:08 +0200 (CEST)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Matt Domsch <mdomsch@Dell.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EFI GUID Partition Tables
In-Reply-To: <200110091725.f99HPZ530405@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33.0110121026430.9327-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

> You've put the devfs_unregister_slave() inside an #ifdef. Yuk! It
> shouldn't be conditional.

I did that because I didn't want to pollute your code. The function
was only needed for the UUID patch.

> And I'm not really sure that I like this
> function in the first place, but that's not something I want to get
> into right now.

I did not see a possibility to cleanly remove a slave that was registered
before. Did I oversee something? Do you thing that functionality is
superfluous?

Regards,
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy






