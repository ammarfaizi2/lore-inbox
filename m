Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269811AbRHIO0L>; Thu, 9 Aug 2001 10:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269812AbRHIO0C>; Thu, 9 Aug 2001 10:26:02 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:6790 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S269811AbRHIOZv>;
	Thu, 9 Aug 2001 10:25:51 -0400
Importance: Normal
Subject: Re: Swapping for diskless nodes
To: "Dirk W. Steinberg" <dws@dirksteinberg.de>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF452D802E.BE93E657-ON85256AA3.004E8422@pok.ibm.com>
From: "Bulent Abali" <abali@us.ibm.com>
Date: Thu, 9 Aug 2001 10:26:22 -0400
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 08/09/2001 10:25:14 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>In such a scenario I would disagree with Alan that network paging is
>high latency as compared to disk access. I have a fully switched 100 Mpbs
>full-duplex ethernet network, and sending a page across the net into
>the memory of a fast server could have much less latency that writing
>that page out to a local old, slow IDE disk.

Have you actually tried swapping over the network using nbd or any other
network device mounted as a swap disk?  Never mind the latency.  Does it
work at all?  I am curious to know.

Last time I checked swapping over nbd required patching the network stack.
Because swapping occurs when memory is low and when memory is low TCP
doesn't do what you expect it to do...
Bulent



