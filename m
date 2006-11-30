Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758616AbWK3B50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758616AbWK3B50 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 20:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758992AbWK3B5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 20:57:25 -0500
Received: from packet.digeo.com ([12.110.80.53]:41886 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id S1758989AbWK3B5Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 20:57:24 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: isochronous receives?
Date: Wed, 29 Nov 2006 17:57:07 -0800
Message-ID: <DD2010E58E069B40886650EE617FCC0CBA8EC9@digeo-mail1.digeo.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: isochronous receives?
Thread-Index: AccTUZEOi7v6J84+R+eLGKj8lA2txQAz+0pA
From: "Keith Curtis" <Keith.Curtis@digeo.com>
To: "Robert Crocombe" <rcrocomb@gmail.com>,
       "linux1394-devel" <linux1394-devel@lists.sourceforge.net>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

I never resolved the problem. I turned on the excessive debugging output, but it 
didn't print out info about receiving packets or interrupts. My test 
app claimed there were no packets received although the bus analyzer 
showed lots of packets going by.  

If I can help out, let me know, but I'm not sure where to start at this point.

Keith


-----Original Message-----
From: Robert Crocombe [mailto:rcrocomb@gmail.com]
Sent: Tuesday, November 28, 2006 4:59 PM
To: Keith Curtis; linux1394-devel; linux-kernel
Subject: isochronous receives?


Keith, et. al,

I am having problems with isochronous receives, and remembered just as
I was getting ready to dig into the source that there was a message
about this stuff.  Lo and behold your message to linux1394-user from
September 7:

> I'm trying to receive isochronous streams (using libraw1394 1.2.0), and
> I've noticed that if data is transmitted on channel 63, then my app tends
> to work fine. If the stream is on a different channel, then I don't see
> any isochronous packets at all.  I'm using 2.4.29, I've also tried 2.6.15
> with similar results, can't seem to receive channels < 63.

Did you ultimately have any success getting this going?  Funnily
enough, when I tested isochronous stuff in July, I just did iso
transmit since I figured receives *must* be working since everyone has
camcorders and whatnot.  My currently my iso xmit stuff does appear to
be working, but iso receives are not.

I have a Firespy and no reason not to trust it, so I can see the junk
I'm spewing out.  I've tried transmitting on channels 4 and 63 (per
your advice), but neither works for me.  I suppose it could my
stuff... nah.

-- 
Robert Crocombe
rcrocomb@gmail.com

