Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271690AbRHQQuB>; Fri, 17 Aug 2001 12:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271691AbRHQQtw>; Fri, 17 Aug 2001 12:49:52 -0400
Received: from [65.105.206.211] ([65.105.206.211]:23633 "EHLO
	MAIL.confluencenetworks.com") by vger.kernel.org with ESMTP
	id <S271690AbRHQQtg> convert rfc822-to-8bit; Fri, 17 Aug 2001 12:49:36 -0400
Subject: RE: Via usb problems...
Date: Fri, 17 Aug 2001 09:48:53 -0700
Message-ID: <71AD71402EB8B04AB30F351C1EE5707C17C861@MAIL.confluencenetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Thread-Topic: Via usb problems...
Thread-Index: AcEnMWgcS0ZAKrnSSIum1t8rlH53jwACNqUw
From: "Curtis Bridges" <cbridges@confluencenetworks.com>
content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
To: <linux-usb-devel@lists.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not a problem, I'll have to wait until my version of "the other side of
the story" let's me get at the computer tomorrow morning (I'm at work
now) in order to get the lspci -v to you but until then I have some
updated URL's for you to work with...

Here is the forum where I tracked the symptoms of the problem, there
signal to noise ratio is not the greatest but there might be some
additional information in there that might help you out:
http://www.msi.com.tw/resellers_club/forum/list_article.php?id=1234

Here is the motherboard makers download of the windows driver, I
downloaded it myself to see if there was additional information provided
in the zip but alas, there wasn't a readme in there, just a windows
installer:
http://www.msi.com.tw/support/driver/others.htm

Here is a link to the same driver (I think) on VIA's website.  I didn't
find any discussions on the website discussing the problem:
http://www.via.com.tw/jsp/en/driver/detail.jsp?hDr_id=12%20%20%20%20&hDr
_os=1&hDr_ver=1.08

As for peripherals, I was experiencing the problem with a Microsoft
Intellimouse Optical:
http://www.microsoft.com/hardware/mouse/optical.asp

I will do some additional tests tomorrow morning (US, EST) when I
provide you the lspci output.  I will try the same mouse in the ps2 slot
as well as some additional usb mice and keyboards.

If there is any additional information or things you would like me to
try, let me know and I would be more than happy to give it a go.  I am a
relative newbie to the low level stuff but I am willing to try anything
you suggest.

Thanks again, Alan.
Curtis



-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Friday, August 17, 2001 11:33 AM
To: Curtis Bridges
Cc: linux-kernel@vger.kernel.org; linux-usb-devel@lists.sourceforge.net
Subject: Re: Via usb problems...


> The work-around for the problem is provided by VIA in the form of some
> updated drivers for windows.  It appears to be some sort of usb
filter,
> possibly for low bandwidth USB peripherals.  I suspect this isn't a
> working resolution for most people on this list and I was wondering if
> anyone has been working on this in the kernel?  I might be able to
> provide some more information if it is needed to diagnose and solve
the
> problem...

Can you provide me

1.	The lspci -v info for your box (chip revision etc)
2.	Details ont he updated windows drivers (eg URL for)
3.	The USB devices

> Does VIA have any engineers working on linux drivers?

Directly, I don't believe so. However they do provide contact points for
some of us and have provided workarounds for other bugs. We now have a 
mechanism in place for making such requests.

Firstly however I'd like the USB folks to look at the debug and traces
to be
sure this isnt a VIA chip bug. If it is I'll take it up with VIA
