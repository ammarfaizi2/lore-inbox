Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287748AbSBKKLN>; Mon, 11 Feb 2002 05:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287764AbSBKKLD>; Mon, 11 Feb 2002 05:11:03 -0500
Received: from patan.Sun.COM ([192.18.98.43]:39333 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S287748AbSBKKKz>;
	Mon, 11 Feb 2002 05:10:55 -0500
Date: Mon, 11 Feb 2002 04:10:20 -0600
From: Spencer Shepler <shepler@eng.sun.com>
To: Pavel Machek <pavel@suse.cz>
Cc: "Kendrick M. Smith" <kmsmith@umich.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, nfs@lists.sourceforge.net,
        nfsv4-wg@sunroof.eng.sun.com
Subject: Re: [NFS] Re: NFS version 4 at the University of Michigan
Message-ID: <20020211041020.E100576@shepler.eng.sun.com>
Reply-To: shepler@eng.sun.com
Mail-Followup-To: Spencer Shepler <shepler@eng.sun.com>,
	Pavel Machek <pavel@suse.cz>,
	"Kendrick M. Smith" <kmsmith@umich.edu>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nfs@lists.sourceforge.net, nfsv4-wg@sunroof.eng.sun.com
In-Reply-To: <Pine.SOL.4.33.0202080036010.1689-100000@rygar.gpcc.itd.umich.edu> <20020209175851.GA113@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020209175851.GA113@elf.ucw.cz>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Pavel Machek wrote:
> Hi!
> 
> > This is an announcement of the first public release of NFS version 4
> > for Linux, by the University of Michigan.  Up to this point, all of
> > our work has been done privately, but we are now hoping to involve
> > the open-source community at large.  Eventually, we hope to integrate
> > our NFS version 4 implementation into the Linux kernel proper, and
> > find a long-term maintainter for NFS version 4 (possibly one of the
> > current NFS maintainers, possibly one of us working in their spare
> > time).
> 
> Could you sumarise advantages of NFSv4 over v3? Is there usermode
> server for NFSv4? What servers for v4 are known working?

The highlights are:
- NFSv4 allows *nix and windows clients to play well with each other
  (NFSv4/CIFS clients can interact appropriately).
- Strong security (authentication/integrity/privacy) is required of
  implementations.
- A single protocol instead of a collection of protocols (e.g. file
  locking, ACL support are in the protocol)
- Delegation (similar to CIFS oplock support) allows for more
  aggressive caching at the client

The University of Michigan/CITI work is the first to "release" but the
other implementations are not far behind.  We will be meeting at
Connectathon in a couple of weeks to do interoperability testing.
Should be a good event.

-- 
Spencer

