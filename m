Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965928AbWKIVLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965928AbWKIVLN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 16:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966044AbWKIVLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 16:11:13 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:49108 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S965928AbWKIVLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 16:11:12 -0500
Message-ID: <4553996C.2060605@scientia.net>
Date: Thu, 09 Nov 2006 22:11:08 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Roger Heflin <rheflin@atipa.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange write errors on FAT32 partition (maybe an FAT32 bug?!)
References: <4550A481.2010408@scientia.net> <87psbzrss2.fsf@duaron.myhome.or.jp> <4553744E.3050007@scientia.net> <45539188.5080607@atipa.com> <45539366.7070809@scientia.net> <45539588.7020504@atipa.com> <45539699.40105@scientia.net> <455397AE.2040207@atipa.com>
In-Reply-To: <455397AE.2040207@atipa.com>
Content-Type: multipart/mixed;
 boundary="------------070101060403030305070902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070101060403030305070902
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Roger Heflin wrote:
> Are both disks of the same type and connected to the same
> hardware?
>
> Or do they have different physical connections/drivers to the
> machine?

The system has 2 DualCore Opterons 275, on a Tyan S2895 board...
The disk with the originak data is a PATA disk from IBM.
The disk where I've copied the stuff to... is a SATA.

I did several diffs the last hours between the two disks and experienced
what you've described, that sometimes no differences sometimes there are
differences (in different files).

But note that the same happened already on the SAME disk.
In the beginning I copied the data to another place on the same disk,
then diffed and there were the same problems.
So I still wonder why this never affects the original files. When I
check sha512sums there I never get an error.


Right now I compile a new kernel with that module... and pray to god
that this is not an hardware error :/

--------------070101060403030305070902
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------070101060403030305070902--
