Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133066AbRDLIGV>; Thu, 12 Apr 2001 04:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133064AbRDLIGM>; Thu, 12 Apr 2001 04:06:12 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:4788 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132959AbRDLIGB>;
	Thu, 12 Apr 2001 04:06:01 -0400
Date: Thu, 12 Apr 2001 04:06:00 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "David S. Miller" <davem@redhat.com>
cc: linux-fsdevel@vger.kernel.org, kowalski@datrix.co.za,
        Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org
Subject: Re: [race][RFC] d_flags use
In-Reply-To: <15061.24772.946396.533296@pizda.ninka.net>
Message-ID: <Pine.GSO.4.21.0104120401290.18135-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Apr 2001, David S. Miller wrote:

> 
> Alexander Viro writes:
>  > If nobody objects I'll go for test_bit/set_bit/clear_bit here.
> 
> Be sure to make d_flags an unsigned long when you do this! :-)

Oh, fsck... Thanks for reminder - I've completely forgotten about
that.
							Al

