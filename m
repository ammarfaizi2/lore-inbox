Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285189AbRLFUsk>; Thu, 6 Dec 2001 15:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284248AbRLFUrF>; Thu, 6 Dec 2001 15:47:05 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:22417 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S285179AbRLFUqL>; Thu, 6 Dec 2001 15:46:11 -0500
Date: 06 Dec 2001 22:14:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8EK0hWIHw-B@khms.westfalen.de>
In-Reply-To: <20011206173455.104b6a02.skraw@ithnet.com>
Subject: Re: Loadable drivers [was SMP/cc Cluster description ]
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <E16BjQJ-0005EA-00@trillium-hollow.org> <20011205212844.451f8781.skraw@ithnet.com> <E16BjQJ-0005EA-00@trillium-hollow.org> <20011206173455.104b6a02.skraw@ithnet.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

skraw@ithnet.com (Stephan von Krawczynski)  wrote on 06.12.01 in <20011206173455.104b6a02.skraw@ithnet.com>:

> I have learned something over the recent years: I guess RMS pointed in the
> right direction. I _don't_ think binary drivers are ok. I want to control my
> environment, and don't let _anybody_ control it _for_ me. And if something
> goes wrong, I have a look. And if I am too dumb, I can ask somebody who
> isn't. And there may be a lot of those.

And it is absolutely amazing what you *can* do, if you have the soure,  
what you never expected to be able to do, but because you *do* have the  
source, you just *have* to look at the problem area ... and poof! there's  
something that certainly doesn't look right, maybe if you just try to  
change this little bit ...

And thus you learn something new which you wouldn't even have tried with  
closed source.

It's not only this. I remember when I first tried to get PPP to work - no,  
wait, back then it was SLIP. (Slightly before Linux 1.0, I think.) It just  
wouldn't work, and I had no idea why. Obviously I was doing something  
wrong, but what?

So I looked at the relevant kernel part. Still rather unclear, but the  
data has to go through *here* ... now suppose I insert a printk there, and  
one there, and then reboot and retry and watch syslog ... aha! (Well,  
actually, it took me several passes, and I don't remember what the problem  
turned out to be except it wasn't a kernel bug.)

MfG Kai
