Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289017AbSBMWaD>; Wed, 13 Feb 2002 17:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289018AbSBMW3y>; Wed, 13 Feb 2002 17:29:54 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:15100
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S289017AbSBMW3k>; Wed, 13 Feb 2002 17:29:40 -0500
Date: Wed, 13 Feb 2002 14:29:42 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Eugene Chupkin <ace@credit.com>
Cc: Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org,
        tmeagher@credit.com, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.x ram issues?
Message-ID: <20020213222942.GB335@matchmail.com>
Mail-Followup-To: Eugene Chupkin <ace@credit.com>,
	Andreas Dilger <adilger@turbolabs.com>,
	linux-kernel@vger.kernel.org, tmeagher@credit.com,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <20020213122159.A16078@lynx.turbolabs.com> <Pine.LNX.4.10.10202131229480.683-100000@mail.credit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10202131229480.683-100000@mail.credit.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 13 Feb 2002, Andreas Dilger wrote:
> > You may need to use a whole bunch of -aa patches to get it to apply.  In
> > general, the -aa tree is tuned for large machines such as yours, so you
> > are probably better off getting the whole thing.
> > 
> 

On Wed, Feb 13, 2002 at 12:33:37PM -0800, Eugene Chupkin wrote:
> Whola!!! This fixed my problem. CONFIG_HIGHIO did it. So my kernel is lets
> see here... 2.4.18pre2aa2+pte-highmem-5. I hope this will be included in
> the 2.4.18 final. Thanks for all your help.
> 

I don't think that will happen.  pte-highmem is relatively new code, and
needs more testing before it goes into 2.4.  Hugh, and Andrea fixed some
potential problems with it recently, so hopefully most of it is ironed out
now.

Also, Andrea and Marcelo (CCed) need to take some time to merge some of -aa into
2.4-pre.  Any comments guys?  We're all watching and waiting to see more
merging in this area...

Mike
