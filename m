Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272549AbRJ3IPE>; Tue, 30 Oct 2001 03:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276032AbRJ3IOz>; Tue, 30 Oct 2001 03:14:55 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:56607 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S272549AbRJ3IOs>; Tue, 30 Oct 2001 03:14:48 -0500
Date: Tue, 30 Oct 2001 10:15:08 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Neale Banks <neale@lowendale.com.au>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nasty suprise with uptime
Message-ID: <20011030101507.G1598@niksula.cs.hut.fi>
In-Reply-To: <E15yJD1-0003uO-00@the-village.bc.nu> <Pine.LNX.4.05.10110301839250.23080-100000@marina.lowendale.com.au> <20011029234615.A14476@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011029234615.A14476@mikef-linux.matchmail.com>; from mfedyk@matchmail.com on Mon, Oct 29, 2001 at 11:46:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 11:46:15PM -0800, you [Mike Fedyk] claimed:
> On Tue, Oct 30, 2001 at 06:46:03PM +1100, Neale Banks wrote:
> >
> > You mean there was a time when uptime>496days would crash a system?
> > 
> > If so, approximtely when did that get fixed?
> > 
> > (I'm thinking back to an as yet unexplained crash of a 2.0.38 system at
> > ~496days uptime :-( )
> 
> AFAIK, the system didn't crash, but the uptime counter went down to zero.

Oh yes, sometimes 2.0 kernel would crash at 497.1 days¹. I guess it depends
on what you were doing at the time and what drivers and options you were
using. I think most of the jiffies wraparound bugs were cleaned at the
2.1.x time (so I have been told.)

(I've experienced one such crash, I'm not sure whether it was 2.0.36 or
2.0.38.)


-- v --

v@iki.fi

¹) it is 497.10 days or 2^32 seconds, not 496 days.
