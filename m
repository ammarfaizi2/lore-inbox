Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129172AbRAZDET>; Thu, 25 Jan 2001 22:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129143AbRAZDEK>; Thu, 25 Jan 2001 22:04:10 -0500
Received: from snoopy.apana.org.au ([202.12.87.129]:11012 "HELO
	snoopy.apana.org.au") by vger.kernel.org with SMTP
	id <S129446AbRAZDEE>; Thu, 25 Jan 2001 22:04:04 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com>
	<94qcvm$9qp$1@cesium.transmeta.com>
	<14960.54069.369317.517425@pizda.ninka.net>
	<3A70D524.11362EFB@transmeta.com>
	<14960.54852.630103.360704@pizda.ninka.net>
	<3A70D7B2.F8C5F67C@transmeta.com>
	<14960.56461.296642.488513@pizda.ninka.net>
From: Brian May <bam@snoopy.apana.org.au>
X-Home-Page: http://snoopy.apana.org.au/~bam/
Date: 26 Jan 2001 14:03:55 +1100
In-Reply-To: davem@redhat.com's message of "26 Jan 01 02:10:21 GMT"
Message-ID: <841ytrypyc.fsf@snoopy.apana.org.au>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David S Miller <davem@redhat.com> writes:

    David> It says "reserved for future use, must be zero".

Poor choice of wording.

If I was implementing this, I would assume that any packet with a
non-zero value is illegal by this RFC, and act accordingly.

I would assume that this "future use" may require handling of the
packet in a non-standard way, and packets with a non-zero value cannot
be used until the "future use" is better defined.

Also, the above statement should really clarify how routers should
cope if they receive a non-zero value. Drop it, pass it through
unchanged, or set it to zero?
-- 
Brian May <bam@snoopy.apana.org.au>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
