Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276327AbRJCObu>; Wed, 3 Oct 2001 10:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276329AbRJCObj>; Wed, 3 Oct 2001 10:31:39 -0400
Received: from embolism.psychosis.com ([216.242.103.100]:42764 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S276328AbRJCObf>; Wed, 3 Oct 2001 10:31:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: "sebastien.cabaniols" <sebastien.cabaniols@laposte.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem uses Linus Torvalds ?
Date: Wed, 3 Oct 2001 10:33:17 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <GKMPCZ$IZh2dKhbICnp0WDXKHB6iO7OKoHwqOxmqj9XfriOC7PjHiIDA6bHi6xrImT@laposte.net>
In-Reply-To: <GKMPCZ$IZh2dKhbICnp0WDXKHB6iO7OKoHwqOxmqj9XfriOC7PjHiIDA6bHi6xrImT@laposte.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15on3F-0005DB-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 October 2001 8:00, sebastien.cabaniols wrote:
> Hello lkml,
>
> With the availability of XFS,JFS,ext3 and ReiserFS I am a
> little
> lost and I don't know which one I should use for entreprise
> class
> servers.

I use Reiserfs on everything now, including a 13 drive Fiber Channel 
SAN with 3 hosts and multiple levels of Software RAID between them.

It is as fast as ext2, and in some case much faster. (IE rm 10K+ files in ~2 
seconds) FYI I Bonnie 70MB/s on 6 7200rpm drives in RAID 0. (64k blocks)

Keeping up with the 'best' reiserfs patch set can be a little bit of a
chore. (However it looks like we're coming to the end of that with 2.4.10)

Never used ext3. From what I did read about it, it didn't excite me.
The others I've yet to see a mature enough version to actually use, and 
considering Reiserfs, don't see a reason to try them.

Dave

-- 
The time is now 22:19 (Totalitarian)  -  http://www.ccops.org/clock.html
