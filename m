Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbTAOFP1>; Wed, 15 Jan 2003 00:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbTAOFP0>; Wed, 15 Jan 2003 00:15:26 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:52117 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261368AbTAOFP0>; Wed, 15 Jan 2003 00:15:26 -0500
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: Con Kolivas <conman@kolivas.net>
Date: Wed, 15 Jan 2003 16:24:00 +1100
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Aggelos Economopoulos <aoiko@cc.ece.ntua.gr>
Subject: Re: [ANNOUNCE] contest benchmark v0.60
Message-ID: <20030115052400.GJ21742@cse.unsw.edu.au>
References: <1042500483.3e234b8335def@kolivas.net> <200301151416.54557.conman@kolivas.net> <20030115041524.GE21742@cse.unsw.edu.au> <200301151539.36960.conman@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301151539.36960.conman@kolivas.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 03:39:34PM +1100, Con Kolivas wrote:
> more I tried to add to it. Also there were subtle things happening in the 
> BASH version that made for much more variation in results than this version. 

I agree, it had begun to outgrow it's bash roots (e.g. i think it was
the ratio section with variables named a b c d e which drove me nuts
when I couldn't figure out which one was giving me a zero value).

> Possibly but clearly c has no major limitations once the hard part (the 
> wrapper for the other applications) has been done. 

I would disagree.  For example, playing tricks with strings,
pipes/redirects and files in C is a complete pain, compared with
perl/python.  Most of the things I changed with the orignal bash
version were in this subset, and it allowed me to customise it for
what we were doing quickly and easily. 

-i
ianw@gelato.unsw.edu.au
http://www.gelato.unsw.edu.au
