Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129398AbRAZKiR>; Fri, 26 Jan 2001 05:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRAZKiH>; Fri, 26 Jan 2001 05:38:07 -0500
Received: from mail.zmailer.org ([194.252.70.162]:50186 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129398AbRAZKh5>;
	Fri, 26 Jan 2001 05:37:57 -0500
Date: Fri, 26 Jan 2001 12:37:49 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "David S. Miller" <davem@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010126123749.E25659@mea-ext.zmailer.org>
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com> <94qcvm$9qp$1@cesium.transmeta.com> <14960.54069.369317.517425@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14960.54069.369317.517425@pizda.ninka.net>; from davem@redhat.com on Thu, Jan 25, 2001 at 05:30:29PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2001 at 05:30:29PM -0800, David S. Miller wrote:
...
> Thirdly, it was widely discussed by the ECN reserachers on how to
> "detect ECN blackholes" sort to speak.  All such schemes suggested
> we unusable, it is not doable without impacting performance _and_
> violating existing RFCs.  Basically, you have to ignore a valid TCP
> reset to deal with some of the ECN holes out there, that is where such
> workaround attempts become full crap and are unsatisfactory for
> inclusion in any implementation much less an RFC.  Happily, we got the
> ECN folks to agree with Alexey and myself on these points.
> 
> So turning it off on a per-connection basis is not really an option.

  But could you nevertheless consider supplying a socket option for it ?
  By all means default it per sysctl, but allow clearing/setting by
  program too.

... 
> Later,
> David S. Miller
> davem@redhat.com

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
