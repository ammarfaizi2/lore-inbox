Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130706AbRA3Rth>; Tue, 30 Jan 2001 12:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131075AbRA3Rt1>; Tue, 30 Jan 2001 12:49:27 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:262 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S130706AbRA3RtN>; Tue, 30 Jan 2001 12:49:13 -0500
Date: Wed, 31 Jan 2001 06:49:11 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: "David S. Miller" <davem@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
Message-ID: <20010131064911.B7244@metastasis.f00f.org>
In-Reply-To: <3A76B72D.2DD3E640@uow.edu.au>, <3A728475.34CF841@uow.edu.au> <3A726087.764CC02E@uow.edu.au> <20010126222003.A11994@vitelus.com> <14966.22671.446439.838872@pizda.ninka.net> <3A76B72D.2DD3E640@uow.edu.au> <14966.47384.971741.939842@pizda.ninka.net> <3A76D6A4.2385185E@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A76D6A4.2385185E@uow.edu.au>; from andrewm@uow.edu.au on Wed, Jan 31, 2001 at 01:58:44AM +1100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 01:58:44AM +1100, Andrew Morton wrote:

    Mount the server rsize=wsize=8192.  `cp' a 102,400,000 byte file
    from the NFS server to /dev/null.  The file is fully cached on
    the server.  unmount and remount the server between runs to
    eliminate client caching. The copy takes 8.654 seconds.  That's
    11.8 megabytes/sec.

What server are you using here? Using NetApp filers I don't see
anything like this, probably only 8.5MB/s at most and this number is
fairly noisy.



  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
