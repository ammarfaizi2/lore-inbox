Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129745AbRAIJeq>; Tue, 9 Jan 2001 04:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129906AbRAIJeg>; Tue, 9 Jan 2001 04:34:36 -0500
Received: from finch-post-10.mail.demon.net ([194.217.242.38]:33806 "EHLO
	finch-post-10.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129745AbRAIJeZ>; Tue, 9 Jan 2001 04:34:25 -0500
Date: Tue, 9 Jan 2001 09:34:14 +0000
From: Roger Gammans <roger@computer-surgery.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
Message-ID: <20010109093414.A7935@knuth.computer-surgery.co.uk>
In-Reply-To: <20010104224946.C1290@redhat.com> <Pine.LNX.4.30.0101031253130.6567-100000@springhead.px.uk.com> <Pine.LNX.4.21.0101031325270.1403-100000@duckman.distro.conectiva> <3A5352ED.A263672D@innominate.de> <20010104192104.C2034@redhat.com> <20010104220821.B775@stefan.sime.com> <20010104224946.C1290@redhat.com> <1628.978695936@redhat.com> <20010106205726.A9664@cerebro.laendle> <20010108120249.J9321@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20010108120249.J9321@redhat.com>; from Stephen C. Tweedie on Mon, Jan 08, 2001 at 12:02:49PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 12:02:49PM +0000, Stephen C. Tweedie wrote:
> Right.  There are two distinct meanings:
> 
> 1) Do not write to this medium, ever (physical readonly); and
> 
> 2) Do not allow modifications to the filesystem (logical readonly).
> 
> The fact is that the kernel confuses the two, but that just isn't
>[snip]
> We just don't have a way of specifying these two things independently.

Is this call for a new mount option?, or should we just
clutter /dev even further with devices with ro permissions as the
marker.

TTFN
-- 
Roger
     Think of the mess on the carpet. Sensible people do all their
     demon-summoning in the garage, which you can just hose down afterwards.
        --     damerell@chiark.greenend.org.uk
	
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
