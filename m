Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267099AbTBUDl0>; Thu, 20 Feb 2003 22:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267107AbTBUDl0>; Thu, 20 Feb 2003 22:41:26 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:63450 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267099AbTBUDlZ>; Thu, 20 Feb 2003 22:41:25 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andi Kleen <ak@suse.de>
Date: Fri, 21 Feb 2003 14:51:07 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15957.41515.937965.343498@notabene.cse.unsw.edu.au>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       aeb@cwi.nl
Subject: Re: sendmsg and IP_PKTINFO
In-Reply-To: message from Andi Kleen on  February 19
References: <15954.4693.893707.471216@notabene.cse.unsw.edu.au.suse.lists.linux.kernel>
	<200302181606.TAA03838@sex.inr.ac.ru.suse.lists.linux.kernel>
	<15954.49970.860809.75554@notabene.cse.unsw.edu.au.suse.lists.linux.kernel>
	<20030218.155651.108799644.davem@redhat.com.suse.lists.linux.kernel>
	<p73wujwy98p.fsf@amdsimf.suse.de>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  February 19, ak@suse.de wrote:
> "David S. Miller" <davem@redhat.com> writes:
> 
> > All you are showing us Neil is that the documentation
> > is inaccurate.  That snippet you showed me from manual
> > pages is wrong about sendmsg semantics.
> 
> Yes, it's wrong I agree. Here is a patch. Please check
> and if nobody complains Andries can apply.
> 

Thanks.  This helps, but I was imagining something a bit
wider-ranging.  In particular I though a "Control Messages" section
would be nice, which enumerated separately all the control messages
that can be recieved, and all those that can be sent.

As far as I can tell, control message are currently defined for:
   IPv4,
   IPv6,
   SOL_HCI - some bluetooth thing
   SOL_SOCKET (which don't seem to be clearly documented in socket(7))

I might try and draft some changes to ip.7 and maybe socket.7 next
week sometime.

NeilBrown
