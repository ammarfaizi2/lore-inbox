Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129679AbRB0Vh2>; Tue, 27 Feb 2001 16:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129709AbRB0VhT>; Tue, 27 Feb 2001 16:37:19 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:62674 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129679AbRB0VhI>;
	Tue, 27 Feb 2001 16:37:08 -0500
Date: Tue, 27 Feb 2001 16:37:06 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "David L. Nicol" <david@kasey.umkc.edu>
cc: Zack Brown <zbrown@tumblerings.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Will Mosix go into the standard kernel?
In-Reply-To: <3A9C1A3A.8BC1BCF2@kasey.umkc.edu>
Message-ID: <Pine.GSO.4.21.0102271630300.4105-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Feb 2001, David L. Nicol wrote:

> /proc/cluster/....	this would be standard root point for clustering stuff
> 
> /proc/mosix would go away, become proc/cluster/mosix
> 
> and the same with whatever bproc puts into /proc; that stuff would move to
> /proc/cluster/bproc

#include <std_rants/Thou_Shalt_Not_Shite_Into_Procfs>

Guys, if you want a large subtree in /proc - whack yourself over the head
until you realize that you want an fs of your own. I'll be more than
happy to help with both parts.

