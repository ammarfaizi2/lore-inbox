Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267018AbRGJSFG>; Tue, 10 Jul 2001 14:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267019AbRGJSE4>; Tue, 10 Jul 2001 14:04:56 -0400
Received: from weta.f00f.org ([203.167.249.89]:46466 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S267018AbRGJSEn>;
	Tue, 10 Jul 2001 14:04:43 -0400
Date: Wed, 11 Jul 2001 06:04:18 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Andi Kleen <ak@suse.de>
Cc: Craig Soules <soules@happyplace.pdl.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
Message-ID: <20010711060418.A32421@weta.f00f.org>
In-Reply-To: <20010710154135.A4603@gruyere.muc.suse.de> <Pine.LNX.3.96L.1010710124338.16113W-100000@happyplace.pdl.cmu.edu> <20010710190602.A8997@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010710190602.A8997@gruyere.muc.suse.de>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 07:06:02PM +0200, Andi Kleen wrote:

    It's the unix semantics of readdir(); e.g. specified in Single Unix:
    
    ``   The type DIR, which is defined in the header <dirent.h>, represents
         a directory stream, which is an ordered sequence of all the
         directory entries in a particular directory. Directory entries
         represent files; files may be removed from a directory or added to
         a directory asynchronously to the operation of readdir(). ''
    
    An ordered sequence does not include cycles.

*Who* says NFS has to be a *unix* like filesystem?



  --cw
