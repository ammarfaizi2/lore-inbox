Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318060AbSHGLOM>; Wed, 7 Aug 2002 07:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318061AbSHGLOM>; Wed, 7 Aug 2002 07:14:12 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:19422 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S318060AbSHGLOL>; Wed, 7 Aug 2002 07:14:11 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Florian Weimer <fw@deneb.enyo.de>
Date: Wed, 7 Aug 2002 21:18:23 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15697.511.36832.939913@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, gam3@acm.org
Subject: Re: Problems with NFS exports
In-Reply-To: message from Florian Weimer on Wednesday August 7
References: <87eldchtr2.fsf@deneb.enyo.de>
	<87k7n3t3zm.fsf@deneb.enyo.de>
	<15696.63765.38094.618742@notabene.cse.unsw.edu.au>
	<8765ymsyzh.fsf@deneb.enyo.de>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday August 7, fw@deneb.enyo.de wrote:
> Neil Brown <neilb@cse.unsw.edu.au> writes:
> 
> > Probably better documentation in exports.5 would be just as useful.
> 
> Maybe.
> 
> BTW, is it possible to export a directory tree under a different path,
> using the kernel NFS daemon?

Uhm... symlinks work.
Which is to say, the client can mount using a 'different path', though
they can also mount using the 'true' path.



> 
> > And "BUSY" probably isn't correct ....
> 
> Why not? The ressource (the directory tree) is already being used, and
> therefore the export fails.

I guess... I just feel it isn't really clear what it is that is
'busy'.

NeilBrown


> 
> > It would be possible to dis-ambiguate the ambiguity but it wouldn't be
> > very clean, and I really am not sure that it is worth the effort.
> 
> Better error messages are always a good idea. :-)

Can't disagree there.

NeilBrown
