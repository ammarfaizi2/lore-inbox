Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266306AbRGJNih>; Tue, 10 Jul 2001 09:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266326AbRGJNiR>; Tue, 10 Jul 2001 09:38:17 -0400
Received: from weta.f00f.org ([203.167.249.89]:37762 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266325AbRGJNiM>;
	Tue, 10 Jul 2001 09:38:12 -0400
Date: Wed, 11 Jul 2001 01:38:05 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Craig Soules <soules@happyplace.pdl.cmu.edu>, jrs@world.std.com,
        linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
Message-ID: <20010711013805.C31799@weta.f00f.org>
In-Reply-To: <15178.3722.86802.671534@charged.uio.no> <Pine.LNX.3.96L.1010709175623.16113S-100000@happyplace.pdl.cmu.edu> <15178.47928.328862.678031@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15178.47928.328862.678031@charged.uio.no>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 10:22:16AM +0200, Trond Myklebust wrote:

    Imagine if somebody gives you a 1Gb directory. Would it or would
    it not piss you off if your file pointer got reset to 0 every time
    somebody created a file?
    
    The current semantics are scalable. Anything which resets the file
    pointer upon change of a file/directory/whatever isn't...

Anyone using a 1GB directory deserves for it not to scale.  I think
this is a very poor example.

No that I disagree with you, the largest directories I have on my
system here are 2.6MB (freedb, lots of hashed flat-files in one
directory), here I do agree that you should not have to reset the
counter everytime.





  --cw
