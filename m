Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRAXVqY>; Wed, 24 Jan 2001 16:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129445AbRAXVqO>; Wed, 24 Jan 2001 16:46:14 -0500
Received: from esteel10.client.dti.net ([209.73.14.10]:38369 "EHLO
	nynews01.e-steel.com") by vger.kernel.org with ESMTP
	id <S129413AbRAXVqD>; Wed, 24 Jan 2001 16:46:03 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
Newsgroups: e-steel.mailing-lists.linux.linux-kernel
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
Date: 24 Jan 2001 16:45:57 -0500
Organization: e-STEEL Netops news server
Message-ID: <m3d7dc62ui.fsf@shookay.e-steel.com>
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCD6@zcard00g.ca.nortel.com>
NNTP-Posting-Host: shookay.e-steel
X-Trace: nynews01.e-steel.com 980372662 11516 192.168.3.43 (24 Jan 2001 21:44:22 GMT)
X-Complaints-To: news@nynews01.e-steel.com
NNTP-Posting-Date: 24 Jan 2001 21:44:22 GMT
X-Newsreader: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jearle@nortelnetworks.com ("Jonathan Earle") writes:

> > I'm back from OZ, and to help deal with my sudden lack of Victoria
> > Bitter, I've made a new zerocopy patch set.
> 
> What are "zerocopy patch set"s?

Basically, if you want to send something to the network, the kernel has to
copy your data to its memory space. It is an overhead and with these
patches, the kernel doesn't has to do it. So it is faster. Moreover, few
ethernet cards are able to compute the ip checksum so linux doesn't need
anymore to do that.
-- 
Mathieu CHOUQUET-STRINGER              E-Mail : mchouque@e-steel.com
     Learning French is trivial: the word for horse is cheval, and
               everything else follows in the same way.
                        -- Alan J. Perlis
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
