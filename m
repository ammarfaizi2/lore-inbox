Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265469AbTAEXqJ>; Sun, 5 Jan 2003 18:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbTAEXqJ>; Sun, 5 Jan 2003 18:46:09 -0500
Received: from smtp07.iddeo.es ([62.81.186.17]:50833 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S265469AbTAEXqI>;
	Sun, 5 Jan 2003 18:46:08 -0500
Date: Mon, 6 Jan 2003 00:54:41 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Nuno Monteiro <nuno@itsari.org>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: updated CDROMREADAUDIO DMA patch
Message-ID: <20030105235441.GA2462@werewolf.able.es>
References: <20030105230752.GA936@hobbes.itsari.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030105230752.GA936@hobbes.itsari.int>; from nuno@itsari.org on Mon, Jan 06, 2003 at 00:07:52 +0100
X-Mailer: Balsa 2.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.01.06 Nuno Monteiro wrote:
> [First of all, excuse me for breaking the thread, I had already deleted 
> your original mail when I ran into this. Sorry for the inconvenience :)]
> 
> On January 4th 2003 Andrew Morton wrote:
> > A refresh and retest of this patch, against 2.4.21-pre2.  It would
> > be helpful if a few (or a lot of) people could test this, and report
> > on the result.   Otherwise it'll never get anywhere...
> 
> Ok, I tested it earlier on today and I ran into an oops & kernel panic. I 
> can read audio cd's just fine (using xmms, gtcd, whatever) for hours, but 
> whenever I try to rip anything using cdparanoia, it goes down south.
> 
> This is 2.4.21-pre2aa2 with some reiserfs fixes Hans posted on lkml a 
> while ago, mind you, and not vanilla 2.4.21-pre2. The patch applied 
> cleanly, though -- not even with offset. Its a run-of-the-mill 48x cdrom 
> (dont even know the brand), connected as slave on the primary IDE 
> channel, which is a PIIX4. Let me know if you need any other info!
> 

Just a me-too, but with the old version. If I try to rip anything with
grip (using cdda2wav as backend), the box just locks. No SysRq.
Curious: one other PIIX4.

Still have to try with this new version.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre2-jam2 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
