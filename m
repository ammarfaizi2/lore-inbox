Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133063AbRDLIBb>; Thu, 12 Apr 2001 04:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133005AbRDLIBW>; Thu, 12 Apr 2001 04:01:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46221 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132938AbRDLIBM>;
	Thu, 12 Apr 2001 04:01:12 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15061.24772.946396.533296@pizda.ninka.net>
Date: Thu, 12 Apr 2001 01:01:08 -0700 (PDT)
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-fsdevel@vger.kernel.org, kowalski@datrix.co.za,
        Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org
Subject: Re: [race][RFC] d_flags use
In-Reply-To: <Pine.GSO.4.21.0104120318150.18135-100000@weyl.math.psu.edu>
In-Reply-To: <200104120700.f3C70W3N016374@webber.adilger.int>
	<Pine.GSO.4.21.0104120318150.18135-100000@weyl.math.psu.edu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alexander Viro writes:
 > If nobody objects I'll go for test_bit/set_bit/clear_bit here.

Be sure to make d_flags an unsigned long when you do this! :-)

Later,
David S. Miller
davem@redhat.com
