Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131047AbRCFSPd>; Tue, 6 Mar 2001 13:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131049AbRCFSPX>; Tue, 6 Mar 2001 13:15:23 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:12805 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131047AbRCFSPQ>; Tue, 6 Mar 2001 13:15:16 -0500
Date: Tue, 6 Mar 2001 12:15:10 -0600
To: Jeff Coy <jcoy@klah.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: binfmt_script and ^M
Message-ID: <20010306121510.A28368@cadcamlab.org>
In-Reply-To: <20010305143445.D6400@tenchi.datarithm.net> <Pine.LNX.4.10.10103060759480.27289-100000@aahz.klah.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.10.10103060759480.27289-100000@aahz.klah.net>; from jcoy@klah.net on Tue, Mar 06, 2001 at 08:14:57AM -0700
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Jeff Coy]
> this issue came up frequently with customers uploading scripts in
> binary mode trying to run #!/usr/bin/perl^M.  The solution for me was
> to just do the following:
> 
> 	cd /usr/bin
> 	sudo ln -s perl^V^M perl

So none of your customers tried '#!/usr/bin/perl -w^M'?  (Come on,
doesn't everyone use -w?)

I'm not for treating \r as IFS in the kernel, but the "simple one-time"
solution is not perfect..

Peter
