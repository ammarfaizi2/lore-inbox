Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131143AbRAHCfh>; Sun, 7 Jan 2001 21:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132106AbRAHCf0>; Sun, 7 Jan 2001 21:35:26 -0500
Received: from james.kalifornia.com ([208.179.0.2]:17272 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S131143AbRAHCfJ>; Sun, 7 Jan 2001 21:35:09 -0500
Message-ID: <3A592749.AF308256@linux.com>
Date: Sun, 07 Jan 2001 18:34:49 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Mau <mau@oscar.prima.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Paket counters for aliased interfaces ?
In-Reply-To: <20010108013812.A17385@oscar.dorf.wh.uni-dortmund.de>
Content-Type: multipart/mixed;
 boundary="------------01AE2D5DB8C04EB2D3B39F35"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------01AE2D5DB8C04EB2D3B39F35
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Patrick Mau wrote:
[...]

> And here's the question:
> I would like to collect statistics for eth0:0 but obviously the
> pakets are only counted for the real interface. If I had enough time
> and knowledge, how should I implement paket counters for aliased
> interfaces ?
>
> PS: Am I right that it isn't possible ? tcpdump doesn't 'work right'
>     either.

Correct.  "eth0" is only a label.  You need to use a userland process such as
firewalling and count the packets.  For tcpdump, specify 'src or dst ....'

-d


--------------01AE2D5DB8C04EB2D3B39F35
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
url:www.blue-labs.org
adr:;;;;;;
version:2.1
email;internet:david@blue-labs.org
title:Blue Labs Developer
note;quoted-printable:GPG key: http://www.blue-labs.org/david@nifty.key=0D=0A
x-mozilla-cpt:;9952
fn:David Ford
end:vcard

--------------01AE2D5DB8C04EB2D3B39F35--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
