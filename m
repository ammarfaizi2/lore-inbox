Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267689AbTBKMOZ>; Tue, 11 Feb 2003 07:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267708AbTBKMOZ>; Tue, 11 Feb 2003 07:14:25 -0500
Received: from pat.uio.no ([129.240.130.16]:53175 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267689AbTBKMOY>;
	Tue, 11 Feb 2003 07:14:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15944.60247.512630.175678@charged.uio.no>
Date: Tue, 11 Feb 2003 13:23:51 +0100
To: Oleg Drokin <green@namesys.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>,
       David Ford <david+powerix@blue-labs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Current NFS issues (2.5.59)
In-Reply-To: <20030211100011.A5850@namesys.com>
References: <3E46E1D6.20709@blue-labs.org>
	<15944.30340.955911.798377@notabene.cse.unsw.edu.au>
	<20030211100011.A5850@namesys.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Oleg Drokin <green@namesys.com> writes:

    >> this started happening when they upgrade from an earlier 2.5
    >> kernel.

     > I think that earlier report was from David too. This is just
     > more detailed report it seems.

     > And while you are listening - I want to share my own NFs
     > problems in 2.5.59 ;) If I try to mount any NFS exported
     > filesystem from the same host (e.g localhost), mount process
     > hangs in D state. Server appears to work ok though and serves
     > requests from external clients.

...and I am unable to reproduce this 8-)

I have a feeling that something is still not right in the IPv4 socket
layer. There are odd memory corruptions etc which I don't see on the
same code in 2.4.x.
Still hunting though, so I may yet find the problems were in my own
code...

Cheers,
  Trond
