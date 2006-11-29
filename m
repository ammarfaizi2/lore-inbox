Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758293AbWK2A7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758293AbWK2A7D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 19:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758292AbWK2A7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 19:59:03 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:27544 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1758293AbWK2A7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 19:59:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hv60eRi6RaN/if5F5R2qNz2gILaWi50/DAxAXuj0cSOJWjs4p5qrelv1qOmhNIkrlLn/56Fp22BIZj2yVuqnGxwJbo7zPvtMJm+QM1YiqGpgO58aj0M8FfN/l2uDWagyeA+bxMfDsDSg869I/b+79Bj52G8QB0Mj9SH+ZOJAGKg=
Message-ID: <e6babb600611281659k2847e169q9c54e9a81454e12a@mail.gmail.com>
Date: Tue, 28 Nov 2006 17:59:00 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: keith.curtis@digeo.com,
       linux1394-devel <linux1394-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: isochronous receives?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
