Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276318AbRJKQuu>; Thu, 11 Oct 2001 12:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276587AbRJKQub>; Thu, 11 Oct 2001 12:50:31 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:16886 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276558AbRJKQuJ>;
	Thu, 11 Oct 2001 12:50:09 -0400
Date: Thu, 11 Oct 2001 12:50:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ignacio Vazquez-Abrams <ignacio@openservices.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11 loses sda9
In-Reply-To: <Pine.LNX.4.33.0110111245490.25209-100000@terbidium.openservices.net>
Message-ID: <Pine.GSO.4.21.0110111248550.22698-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Oct 2001, Ignacio Vazquez-Abrams wrote:

> Ouch. You may have to use partedit from PartitionMagic (or some other
> low-level partition editor) to manually change the partition type.

Like, say it, dd(1).  However, partitioning code doesn't give a damn for
entry type - "empty" means "zero number of sectors" for it.  Something
very screwy is going on.

