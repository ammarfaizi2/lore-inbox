Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266377AbRHFCOm>; Sun, 5 Aug 2001 22:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266400AbRHFCOd>; Sun, 5 Aug 2001 22:14:33 -0400
Received: from [24.93.67.54] ([24.93.67.54]:13580 "EHLO mail7.carolina.rr.com")
	by vger.kernel.org with ESMTP id <S266377AbRHFCOV>;
	Sun, 5 Aug 2001 22:14:21 -0400
From: Zilvinas Valinskas <zvalinskas@carolina.rr.com>
Date: Sun, 5 Aug 2001 22:13:21 -0400
To: "Stephen C. Tweedie" <sct@redhat.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010805221321.A2283@clt88-175-140.carolina.rr.com>
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <01080316082001.01827@starship> <20010803111803.B25450@cs.cmu.edu> <01080317471707.01827@starship> <20010803165036.C12470@redhat.com> <20010803201112.D31468@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010803201112.D31468@emma1.emma.line.org>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 08:11:12PM +0200, Matthias Andree wrote:
> On Fri, 03 Aug 2001, Stephen Tweedie wrote:
> 
> > > We don't need all the paths, and not any specific path, just a path.
> > 
> > Exactly, because fsync makes absolutely no gaurantees about the
> > namespace.  So a lost+found path is quite sufficient.
> 
> MTA authors don't share this. lost+found is "invisible" for the
> application that created the file.
> 
> I have yet to meet a distribution which scans lost+found at boot time
> and syslogs found files or sends root a mail.

Debian Woody ...
> 
> So, effectively, lost+found will NOT be sufficient. Discarding file
> names at will is not a good thing.
> 
> -- 
> Matthias Andree
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Zilvinas Valinskas
