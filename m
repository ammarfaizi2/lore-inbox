Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130399AbRAaLjm>; Wed, 31 Jan 2001 06:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130673AbRAaLjc>; Wed, 31 Jan 2001 06:39:32 -0500
Received: from styx.suse.cz ([195.70.145.226]:54268 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130399AbRAaLjZ>;
	Wed, 31 Jan 2001 06:39:25 -0500
Date: Wed, 31 Jan 2001 12:39:19 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: David Raufeisen <david@fortyoz.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
Message-ID: <20010131123919.A1399@suse.cz>
In-Reply-To: <Pine.LNX.4.21.0101301716490.3105-100000@ns-01.hislinuxbox.com> <Pine.LNX.4.21.0101301755330.3205-200000@ns-01.hislinuxbox.com> <20010131083642.A964@suse.cz> <20010130235525.A7513@fortyoz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010130235525.A7513@fortyoz.org>; from david@fortyoz.org on Tue, Jan 30, 2001 at 11:55:25PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2001 at 11:55:25PM -0800, David Raufeisen wrote:
> On Wednesday, 31 January 2001, at 08:36:42 (+0100),
> Vojtech Pavlik wrote:
> 
> > Hi!
> > 
> > 1) You don't seem to have any drives on the VIA controller. If this is
> > true, I don't think this can be a VIA IDE driver problem.
> >
> 
> Hi, Are you referring to Mark or me?

I was referring to David D.W. Downey, the one who started this thread.
He was in the To: fiels, you and Mark were in Cc:

> > 2) In your original message you suggest bs=1024M, which isn't a very
> > good idea, even on a 768 MB system. Here with bs=1024k it seems to run
> > fine.
> >
> > 3) You sent next to none VIA related debugging info. lspci -v itself
> > isn't much valuable because I don't get the register contents. Also
> > hdparm -i of the drives attached to the VIA chip would be useful. Plus
> > also the contents of /proc/ide/via.
> 
> I didn't supply anything either, even though my configuration works great it
> might prove useful to someone comparing:

Sorry, this message indeed was directed to someone else. Thanks for your
info, anyway, it's always useful to have some positive evidence that the
thing does work for people.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
