Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276337AbRJCOsx>; Wed, 3 Oct 2001 10:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276338AbRJCOsm>; Wed, 3 Oct 2001 10:48:42 -0400
Received: from [195.157.147.30] ([195.157.147.30]:19208 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S276337AbRJCOsi>; Wed, 3 Oct 2001 10:48:38 -0400
Date: Wed, 3 Oct 2001 15:48:40 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: "sebastien.cabaniols" <sebastien.cabaniols@laposte.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem uses Linus Torvalds ?
Message-ID: <20011003154840.L30743@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	"sebastien.cabaniols" <sebastien.cabaniols@laposte.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <GKMPCZ$IZh2dKhbICnp0WDXKHB6iO7OKoHwqOxmqj9XfriOC7PjHiIDA6bHi6xrImT@laposte.net> <E15on3F-0005DB-00@schizo.psychosis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15on3F-0005DB-00@schizo.psychosis.com>; from dcinege@psychosis.com on Wed, Oct 03, 2001 at 10:33:17AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use ext3 on a couple of servers and a couple of laptops.  I think which fs is
best for you will depend enormously on the intended use of the machines and
your own expectations.  A mail and dns server that I operate running ext3 has
been very happy since conversion, and has definitely benefitted.

I feel I get the benefit of no more fscks and fast operations on "-o
sync"-mounted filesystems without (IMO) exposing the box to immature code that
you might see in less conservative "experimental" filesystem options.

I personally feel more comfortable with the stability and robustness criteria
of the ext3 developers than some others.  If you want a very fast filesystem or
one that handles very large numbers of files very well, your choice may well be
different from mine.

I quite like my filesystems to be boring. :)

Sean

On Wed, Oct 03, 2001 at 10:33:17AM -0400, Dave Cinege wrote:
> On Wednesday 03 October 2001 8:00, sebastien.cabaniols wrote:
> > Hello lkml,
> >
> > With the availability of XFS,JFS,ext3 and ReiserFS I am a
> > little
> > lost and I don't know which one I should use for entreprise
> > class
> > servers.
> 
> I use Reiserfs on everything now, including a 13 drive Fiber Channel 
> SAN with 3 hosts and multiple levels of Software RAID between them.
> 
> It is as fast as ext2, and in some case much faster. (IE rm 10K+ files in ~2 
> seconds) FYI I Bonnie 70MB/s on 6 7200rpm drives in RAID 0. (64k blocks)
> 
> Keeping up with the 'best' reiserfs patch set can be a little bit of a
> chore. (However it looks like we're coming to the end of that with 2.4.10)
> 
> Never used ext3. From what I did read about it, it didn't excite me.
> The others I've yet to see a mature enough version to actually use, and 
> considering Reiserfs, don't see a reason to try them.
> 
> Dave
> 
> -- 
> The time is now 22:19 (Totalitarian)  -  http://www.ccops.org/clock.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
