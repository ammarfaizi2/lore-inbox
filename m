Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132316AbRDWV5V>; Mon, 23 Apr 2001 17:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132326AbRDWV5L>; Mon, 23 Apr 2001 17:57:11 -0400
Received: from venus.Sun.COM ([192.9.25.5]:19129 "EHLO venus.Sun.COM")
	by vger.kernel.org with ESMTP id <S132316AbRDWV45>;
	Mon, 23 Apr 2001 17:56:57 -0400
From: "Pawel Worach" <pworach@mysun.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Reply-To: pawel.worach@mysun.com
Message-ID: <3804336226.3622638043@mysun.com>
Date: Mon, 23 Apr 2001 23:48:25 +0200
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: en
Subject: Re: i810_audio broken?
X-Accept-Language: en
Content-Type: multipart/mixed; boundary="--279a1a0f6ee47fb1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

----279a1a0f6ee47fb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

sorry the kernel version is 2.4.3-ac12, so it's kind of latest...

I was using mpg123 (xmms and c/o does exactly the same)
if I run it like this Moby sounds very stupid... :)
[root@whyami mp3]# mpg123 -r 48000 Moby_01.wav.mp3 
unsupported playback rate: 44100
Audio device open for 44.1Khz, stereo, 16bit failed
Trying 44.1Khz, 8bit stereo.
unsupported sound format: 32
Audio device open for 44.1Khz, stereo, 8bit failed
Trying 48Khz, 16bit stereo.

Cheers
Pawel Worach
PostGirot Bank AB
----- Original Message -----
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Monday, April 23, 2001 9:53 pm
Subject: Re: i810_audio broken?

> > The i810 audio driver is broken on my Fujitsu Lifebook
> > S-4546. All output is just noise. Here is a snip's from
> > the kernel log.
> > 
> > Intel 810 + AC97 Audio, version 0.02, 19:41:16 Apr 23 2001
> > PCI: Found IRQ 9 for device 00:00.1
> > PCI: The same IRQ used for device 00:00.2
> > PCI: The same IRQ used for device 00:13.1
> > PCI: Setting latency timer of device 00:00.1 to 64
> > i810: Intel 440MX found at IO 0x1cc0 and 0x1000, IRQ 9
> > ac97_codec: AC97 Audio codec, id: 0x594d:0x4800 (Unknown)
> > i810_audio: only 48Khz playback available
> 
> The dump looks fine. Its a cheap and cheeerful codec however by the 
> look of it.
> Make sure the applications you use properly handle 48Khz only 
> audio. That
> may be the problem or maybe not.
> 
> Also try the very latest kernels as a fair bit of work has been 
> done on them
> 
> 

----279a1a0f6ee47fb1
Content-Type: text/x-vcard; name="pworach.vcf"; charset=us-ascii
Content-Disposition: attachment; filename="pworach.vcf
Content-Description: Card for <pworach@mysun.com>
Content-Transfer-Encoding: 7bit

begin:vcard
n:Worach;Pawel
fn:Pawel Worach
version:2.1
email;internet:pawel.worach@mysun.com
end:vcard

----279a1a0f6ee47fb1--

