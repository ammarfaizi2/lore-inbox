Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262666AbREOH4d>; Tue, 15 May 2001 03:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262669AbREOH4X>; Tue, 15 May 2001 03:56:23 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:28169 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S262666AbREOH4M>; Tue, 15 May 2001 03:56:12 -0400
Date: Tue, 15 May 2001 19:56:07 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
Message-ID: <20010515195607.A13722@metastasis.f00f.org>
In-Reply-To: <200105150649.f4F6nwD22946@vindaloo.ras.ucalgary.ca> <Pine.LNX.4.21.0105142357220.23955-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0105142357220.23955-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, May 15, 2001 at 12:13:13AM -0700
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2001 at 12:13:13AM -0700, Linus Torvalds wrote:

    We should not create crap code just because we _can_.

How about removing code?


In 2.5.x is we move fs metadata into the pagecache, do we even need a
buffer cache anymore? Can't we just ditch it completely and make all
device access raw?

It seems to me this is not only simple but also elegant, or perhaps I
am fundamentally missing something?



  --cw
