Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261446AbSK0DTn>; Tue, 26 Nov 2002 22:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbSK0DTn>; Tue, 26 Nov 2002 22:19:43 -0500
Received: from pat.uio.no ([129.240.130.16]:56796 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S261446AbSK0DTm>;
	Tue, 26 Nov 2002 22:19:42 -0500
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] htree+NFS (NFS client bug?)
References: <1038354285.1302.144.camel@sherkaner.pao.digeo.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 27 Nov 2002 04:26:46 +0100
In-Reply-To: <1038354285.1302.144.camel@sherkaner.pao.digeo.com>
Message-ID: <shsptsrd761.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jeremy Fitzhardinge <jeremy@goop.org> writes:

     > It looks to me like some sort of problem managing the NFS
     > readdir cookies, but it isn't clear to me whether this is the
     > NFS server/ext3 generating bad cookies, or the NFS client
     > handling them wrongly.

In order to determine which of the two needs to be fixed, it would
help if you could print out the cookies from that listing or better
still: if you could provide us with the raw tcpdump output. Please
remember to use an 8k snaplen for the tcpdump...

Cheers,
  Trond
