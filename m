Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130799AbRBWX3z>; Fri, 23 Feb 2001 18:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130841AbRBWX3p>; Fri, 23 Feb 2001 18:29:45 -0500
Received: from eschelon.gamesquad.net ([216.115.239.45]:40199 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S130799AbRBWX32>; Fri, 23 Feb 2001 18:29:28 -0500
From: "Vibol Hou" <vhou@khmer.cc>
To: "Vibol Hou" <vhou@khmer.cc>, "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: UDP attack? How to suppress kernel msgs?
Date: Fri, 23 Feb 2001 15:29:04 -0800
Message-ID: <NDBBKKONDOBLNCIOPCGHGEMBEOAA.vhou@khmer.cc>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0068_01C09DAD.5B08F2B0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <NDBBKKONDOBLNCIOPCGHIEMAEOAA.vhou@khmer.cc>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0068_01C09DAD.5B08F2B0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I have an MRTG chart of what happened during the attack and have attached
it.  Does anyone know why the bandwidth going OUT spiked up so high and just
cratered?  Green is incoming, blue is outgoing.

Thanks,
Vibol Hou

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Vibol Hou
Sent: Friday, February 23, 2001 3:22 PM
To: Linux-Kernel
Subject: UDP attack? How to suppress kernel msgs?


Hi,

One of my servers running 2.4.1 was attacked earlier today.  I have a strong
feeling it went down because the kernel was logging too many messages to
syslog.  There's over 100,000 lines of the following in my syslog:

Feb 23 12:28:25 omega kernel: UDP: bad checksum. From 202.96.140.146:20567
to 21
6.115.239.40:113 ulen 1472
Feb 23 12:28:25 omega kernel: UDP: bad checksum. From 209.249.213.145:36338
to 2
16.115.239.40:113 ulen 1472
Feb 23 12:28:25 omega kernel: UDP: bad checksum. From 194.225.45.233:33762
to 21
6.115.239.40:113 ulen 1472
Feb 23 12:28:25 omega kernel: UDP: bad checksum. From 211.54.39.161:14958 to
216
.115.239.40:113 ulen 1472
Feb 23 12:28:25 omega kernel: UDP: bad checksum. From 202.96.140.167:3467 to
216
.115.239.40:113 ulen 1472

How do I suppress these types of messages from hogging up all the CPU?

Thanks,
Vibol Hou

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

------=_NextPart_000_0068_01C09DAD.5B08F2B0
Content-Type: application/octet-stream;
	name="khmerconnection.com-day[1].png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="khmerconnection.com-day[1].png"

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
Kf8HqTKsQWAuz8gAAAAASUVORK5CYII=

------=_NextPart_000_0068_01C09DAD.5B08F2B0--

