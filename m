Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285073AbSATVJW>; Sun, 20 Jan 2002 16:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286756AbSATVJC>; Sun, 20 Jan 2002 16:09:02 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:58095 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S285073AbSATVIx>; Sun, 20 Jan 2002 16:08:53 -0500
Date: Sun, 20 Jan 2002 23:08:41 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors
Message-ID: <20020120210841.GU51774@niksula.cs.hut.fi>
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain> <Pine.LNX.3.95.1020118163838.3008B-100000@chaos.analogic.com> <a2afsg$73g$2@ncc1701.cistron.net> <20020120152359.B326@localhost> <20020120200255.GG135220@niksula.cs.hut.fi> <20020120214430.A4000@devcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020120214430.A4000@devcon.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2002 at 09:44:31PM +0100, you [Andreas Ferber] claimed:
> On Sun, Jan 20, 2002 at 10:02:55PM +0200, Ville Herva wrote:
> > 
> > Just out of interest (I'm not actually suggesting this would be useful, or
> > feasible): what about ilink(dev, inode_nr, "path") or iopen(dev, inode_nr)?
> > 
> > Or /proc/inodes/dev/<nr> ?
> 
> ...which would successfully defeat any access control scheme based on
> directory permissions...

Yeah - it could be root-only.

But it's propably not useful anyway.


-- v --

v@iki.fi
