Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272305AbRIKHIK>; Tue, 11 Sep 2001 03:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272309AbRIKHIB>; Tue, 11 Sep 2001 03:08:01 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:57092 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S272305AbRIKHHt>; Tue, 11 Sep 2001 03:07:49 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Marcus Sundberg <marcus@cendio.se>
Date: Tue, 11 Sep 2001 17:07:52 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15261.47176.73283.841982@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: nfs is stupid ("getfh failed")
In-Reply-To: message from Marcus Sundberg on  September 10
In-Reply-To: <002b01c136e1$3bb36a80$81d4870a@cartman>
	<15260.25562.278698.458611@notabene.cse.unsw.edu.au>
	<ve66arqtln.fsf@inigo.sthlm.cendio.se>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  September 10, marcus@cendio.se wrote:
> neilb@cse.unsw.edu.au (Neil Brown) writes:
> 
> > SUNs "cachefs" concept can be used to improve read performance by
> > caching a lot more of server-data on the client.  That could be
> > implemented for Linux, but I don't know of anyone with serious plans.
> 
> cachefs sucks. It doesn't seem to cache stat(2) information.
> Doing ls -F in a ~100-entries directory takes several seconds over
> a link with 50ms round-trip time.

Well, I said "concept" not "implementation", but I suspect that
Solaris cachefs does cache stat information.  Maybe you just need to
increase the timeouts for the attribute cache.

NeilBrown
