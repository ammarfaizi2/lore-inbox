Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133105AbRDXWkI>; Tue, 24 Apr 2001 18:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135511AbRDXWj6>; Tue, 24 Apr 2001 18:39:58 -0400
Received: from pat.uio.no ([129.240.130.16]:26100 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S133105AbRDXWjr>;
	Tue, 24 Apr 2001 18:39:47 -0400
To: <apark@cdf.toronto.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.19 and file lock on NFS?
In-Reply-To: <Pine.LNX.4.30.0104241633490.19976-100000@penguin.cdf.toronto.edu>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 25 Apr 2001 00:39:43 +0200
In-Reply-To: <apark@cdf.toronto.edu>'s message of "Tue, 24 Apr 2001 16:38:10 -0400 (EDT)"
Message-ID: <shsvgntkjm8.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == apark  <apark@cdf.toronto.edu> writes:

     > Hi, Recently upgraded to 2.2.19, along with new
     > nfs-utils(0.3.1).  But I have a program that requires a
     > exclusive write lock on a NFSed directory.  When I was using
     > 2.2.17 all was ok, but now it returns ENOLCK.  Does anybody
     > else have the same problem?  Thanks

Hi,

You are probably failing to run the statd daemon or you may have set
up over-restrictive /etc/hosts.(allow|deny).

See the latest NFS-HOWTO for a full description on how to set up
locking.

Cheers,
  Trond
