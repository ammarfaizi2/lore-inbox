Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266343AbUAOCE0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 21:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266344AbUAOCE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 21:04:26 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:10459 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S266343AbUAOCEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 21:04:25 -0500
Date: Thu, 15 Jan 2004 03:04:22 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Slow NFS performance over wireless!
Message-ID: <20040115020422.GE20560@drinkel.cistron.nl>
References: <Pine.LNX.4.44.0401060055570.1417-100000@poirot.grange> <200401130155.32894.hackeron@dsl.pipex.com> <1074025508.1987.10.camel@lumiere> <1074026758.4524.65.camel@nidelv.trondhjem.org> <bu4pd6$anf$1@news.cistron.nl> <20040115013312.GO1594@srv-lnx2600.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040115013312.GO1594@srv-lnx2600.matchmail.com> (from mfedyk@matchmail.com on Thu, Jan 15, 2004 at 02:33:12 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jan 2004 02:33:12, Mike Fedyk wrote:
> On Thu, Jan 15, 2004 at 01:12:07AM +0000, Miquel van Smoorenburg wrote:
> > On an NFS client (2.6.1-mm3, filesystem mounted with options
> > udp,nfsvers=3,rsize=32768,wsize=32768) I get for the same share as
> > write/rewrite/read speeds 36 / 4 / 38 MB/sec. CPU load is also
> > very high on the client for the rewrite case (80%).
> > 
> 
> What is your throughput on the wire?

Oh, the network is just fine.

# tcpspray -n 100000 192.168.29.132
Transmitted 102400000 bytes in 0.960200 seconds (104144.970 kbytes/s)

> And retry with tcp instead of udp...

I did test with TCP, results are comparable to UDP.

Mike.
