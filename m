Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263611AbTCUMl2>; Fri, 21 Mar 2003 07:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263615AbTCUMl1>; Fri, 21 Mar 2003 07:41:27 -0500
Received: from pat.uio.no ([129.240.130.16]:6562 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S263611AbTCUMl0>;
	Fri, 21 Mar 2003 07:41:26 -0500
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Daniel Pittman <daniel@rimspace.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux <-> Linux NFS issues.
References: <87isudm2ee.fsf@enki.rimspace.net> <20030321123214.GB6664@suse.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 21 Mar 2003 13:52:08 +0100
In-Reply-To: <20030321123214.GB6664@suse.de>
Message-ID: <shs1y103mrr.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave Jones <davej@codemonkey.org.uk> writes:

     > On Fri, Mar 21, 2003 at 09:37:13PM +1100, Daniel Pittman wrote:
    >> The client machine reports, in dmesg: NFS: server cheating in
    >> read reply: count 4096 > recvd 1000 The 'count' value is
    >> occasionally higher, but not often, and the 'recvd' never seems
    >> to differ from 1000.

     > When I was last seeing this, there was also a lot of 'crap'
     > packets on the wire, with bogus header lengths etc (some of
     > which were so malformed they broke ethereal).

     > I've not retried any NFS tests since 2.5.60, sounds like the
     > problem is still there, so I'll do some more investigation
     > soon.

Dave,

Are you seeing bogus packets from both the 2.5.x client and the
server, or is it just the server (or just the client)?
It could also be interesting to find out if this is a UDP only
problem, or if it occurs with TCP too...

Cheers,
  Trond
