Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263659AbRFAS0Z>; Fri, 1 Jun 2001 14:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263536AbRFAS0P>; Fri, 1 Jun 2001 14:26:15 -0400
Received: from mons.uio.no ([129.240.130.14]:35987 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S263395AbRFAS0C>;
	Fri, 1 Jun 2001 14:26:02 -0400
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [newbie] NFS client: port-unreachable
In-Reply-To: <Pine.LNX.4.31.0106011855520.13429-100000@pc40.e18.physik.tu-muenchen.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 01 Jun 2001 20:22:03 +0200
In-Reply-To: Roland Kuhn's message of "Fri, 1 Jun 2001 19:04:32 +0200 (CEST)"
Message-ID: <shsd78o2h84.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de> writes:

     > Hi folks!  When I lstat64 a directory on an nfs mount the
     > answer to GETATTR is received by the network interface but
     > dropped (not seen by the client) afterwards. Only 50musec after
     > the receive of the answer an icmp-destination-unreachable
     > (port-unreachable) goes out to the server.  This is annoying
     > since it blocks all access to that directory.  The request in
     > question is sent and received at port 772.

     > I'm using kernel 2.4.4.

You probably have set ipchains or ipfilter to block port 772 on your
client.

Cheers,
  Trond
