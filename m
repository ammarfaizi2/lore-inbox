Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266301AbRGJNdh>; Tue, 10 Jul 2001 09:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266303AbRGJNd2>; Tue, 10 Jul 2001 09:33:28 -0400
Received: from weta.f00f.org ([203.167.249.89]:36738 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266301AbRGJNdS>;
	Tue, 10 Jul 2001 09:33:18 -0400
Date: Wed, 11 Jul 2001 01:33:11 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Andi Kleen <ak@suse.de>
Cc: Craig Soules <soules@happyplace.pdl.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
Message-ID: <20010711013311.B31799@weta.f00f.org>
In-Reply-To: <Pine.LNX.3.96L.1010709131315.16113O-200000@happyplace.pdl.cmu.edu.suse.lists.linux.kernel> <oupbsmueyv8.fsf@pigdrop.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oupbsmueyv8.fsf@pigdrop.muc.suse.de>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2001 at 08:33:31PM +0200, Andi Kleen wrote:

    Actually all the file systems who do that on Linux (JFS, XFS,
    reiserfs) have fixed the issue properly server side, by adding a
    layer that generates stable cookies. You should too.

I've always thought that was a stupid fix. Why not have the clients be
smarted and make them responsible for getting a new cookie if the old
one is hosed?

For linux, with the dcache, I'm not even sure that this would be all
the hard. Persumable Solaris could (does?) do the same?



  --cw
