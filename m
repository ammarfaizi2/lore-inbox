Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVG2RjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVG2RjN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 13:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbVG2RjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 13:39:13 -0400
Received: from [202.125.86.130] ([202.125.86.130]:8864 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S262631AbVG2RjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 13:39:11 -0400
Content-class: urn:content-classes:message
Subject: RE: Unable to mount the SD card formatted using the DIGITAL CAMREA on Linux box
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C59464.68A61062"
Date: Fri, 29 Jul 2005 23:05:50 +0530
Message-ID: <C349E772C72290419567CFD84C26E017042058@mail.esn.co.in>
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Unable to mount the SD card formatted using the DIGITAL CAMREA on Linux box
thread-index: AcWUQ5eUBWmJXYK1SQ6wxXaIm8pJawAFrsBw
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>,
       "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Srinivas G." <srinivasg@esntechnologies.co.in>,
       "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C59464.68A61062
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable


Dear Lennart, Dick Johnson, Erik Mouw & All,

Thanks for all ur precious support.=20

The cannon camera (other devices too) formatted SD is indeed a partition
FAT12. When I said=20
sfdisk -l, it showed the fs ID as 1. 1 is indeed the FAT12 fs ID.

Attached are the logs for win and camera device sfdisk -Vl /dev/tfa0.

The SD card formatted in camera is partitioned FAT12 disk.
Also, the SD card formatted in windows is partitioned FAT12 disk.
(see the attachment)

on ur suggestion I verified whether camera partition device has a valid
FS ID. I verified. It is FAT12. It is the same for windows=20
formatted device. The FS ID of both the formats is 1. i.e. FAT12.

I has notion that my driver is not supporting partition devices. This
makes this clean that my driver is supporting the partition devices
(windows formatted SD). If both are partitioned where is the difference?


So, can someone please help me telling what else could be missing that
is creating this problem?

Regards,
Mukund Jampala


>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Lennart Sorensen
>Sent: Friday, July 29, 2005 7:08 PM
>To: linux-os (Dick Johnson)
>Cc: Srinivas G.; linux-kernel-Mailing-list
>Subject: Re: Unable to mount the SD card formatted using the DIGITAL
CAMREA
>on Linux box
>
>On Fri, Jul 29, 2005 at 08:02:14AM -0400, linux-os (Dick Johnson)
wrote:
>> Execute linux `fdisk` on the device. You may find that the
>> ID byte is wrong.
>>
>> Also, why do you need a special block device driver? The SanDisk
>> and CompacFlash devices should look like IDE drives.
>
>SD usually is secure digital (MMC compatible somewhat I believe).  It
>does not provide IDE unlike CompactFlash.  SD uses a serial interface
if
>I remember correctly.
>
>Len Sorensen
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

------_=_NextPart_001_01C59464.68A61062
Content-Type: text/plain;
	name="win-camera-sdfisk-details.txt"
Content-Transfer-Encoding: base64
Content-Description: win-camera-sdfisk-details.txt
Content-Disposition: attachment;
	filename="win-camera-sdfisk-details.txt"

CmNhbWVyYSBmb3JtYXR0ZWQgaW5mbwotLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkRpc2sgL2Rldi90
ZmEwOiA0NDggY3lsaW5kZXJzLCAyIGhlYWRzLCAzMiBzZWN0b3JzL3RyYWNrClVuaXRzID0gY3ls
aW5kZXJzIG9mIDMyNzY4IGJ5dGVzLCBibG9ja3Mgb2YgMTAyNCBieXRlcywgY291bnRpbmcgZnJv
bSAwCgogICBEZXZpY2UgQm9vdCBTdGFydCAgICAgRW5kICAgI2N5bHMgICAgI2Jsb2NrcyAgIElk
ICBTeXN0ZW0KL2Rldi90ZmEwcDEgICAqICAgICAgMCsgICAgNDQ5ICAgICA0NTAtICAgICAxNDM3
MSsgICAxICBGQVQxMgovZGV2L3RmYTBwMiAgICAgICAgICAwICAgICAgIC0gICAgICAgMCAgICAg
ICAgICAwICAgIDAgIEVtcHR5Ci9kZXYvdGZhMHAzICAgICAgICAgIDAgICAgICAgLSAgICAgICAw
ICAgICAgICAgIDAgICAgMCAgRW1wdHkKL2Rldi90ZmEwcDQgICAgICAgICAgMCAgICAgICAtICAg
ICAgIDAgICAgICAgICAgMCAgICAwICBFbXB0eQpXYXJuaW5nOiBwYXJ0aXRpb24gMSBleHRlbmRz
IHBhc3QgZW5kIG9mIGRpc2sKCldpbmRvd3MgZm9ybWF0dGVkIGluZm8KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQpEaXNrIC9kZXYvdGZhMDogNDQ4IGN5bGluZGVycywgMiBoZWFkcywgMzIgc2VjdG9y
cy90cmFjawpVbml0cyA9IGN5bGluZGVycyBvZiAzMjc2OCBieXRlcywgYmxvY2tzIG9mIDEwMjQg
Ynl0ZXMsIGNvdW50aW5nIGZyb20gMAoKICAgRGV2aWNlIEJvb3QgU3RhcnQgICAgIEVuZCAgICNj
eWxzICAgICNibG9ja3MgICBJZCAgU3lzdGVtCi9kZXYvdGZhMHAxICAgKiAgICAgIDArICAgIDQ0
OSAgICAgNDUwLSAgICAgMTQzNzErICAgMSAgRkFUMTIKL2Rldi90ZmEwcDIgICAgICAgICAgMCAg
ICAgICAtICAgICAgIDAgICAgICAgICAgMCAgICAwICBFbXB0eQovZGV2L3RmYTBwMyAgICAgICAg
ICAwICAgICAgIC0gICAgICAgMCAgICAgICAgICAwICAgIDAgIEVtcHR5Ci9kZXYvdGZhMHA0ICAg
ICAgICAgIDAgICAgICAgLSAgICAgICAwICAgICAgICAgIDAgICAgMCAgRW1wdHkKV2FybmluZzog
cGFydGl0aW9uIDEgZXh0ZW5kcyBwYXN0IGVuZCBvZiBkaXNrCg==

------_=_NextPart_001_01C59464.68A61062--
