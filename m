Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161834AbWKIUpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161834AbWKIUpb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 15:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965928AbWKIUpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 15:45:31 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:48851 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S965997AbWKIUpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 15:45:30 -0500
Message-ID: <45539366.7070809@scientia.net>
Date: Thu, 09 Nov 2006 21:45:26 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Roger Heflin <rheflin@atipa.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange write errors on FAT32 partition (maybe an FAT32 bug?!)
References: <4550A481.2010408@scientia.net> <87psbzrss2.fsf@duaron.myhome.or.jp> <4553744E.3050007@scientia.net> <45539188.5080607@atipa.com>
In-Reply-To: <45539188.5080607@atipa.com>
Content-Type: multipart/mixed;
 boundary="------------070103070701090606000204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070103070701090606000204
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Roger Heflin wrote:
> Christoph,
>
> Install then edac_mc module, and make sure  through the
> sysctl command that pci parity checking is enabled.
>
> I have seen pci parity errors produce this sort of results,
> ie make 100 identical 50MB files, and cksum them and one
> will be wrong, do it a again, and the "wrong" one is now
> right, but someone else is "wrong".
Ah thx,... is it in the vanilla kernel?
And do you know of any possible results that this issue has? When I just
read data (see my original stuff with fat32) is it possible that this
had been modified or damaged?
Or are the only consequences that diff errors occur?

And what is responsible for that parity errors? Is it possible that any
hardware is damaged?

Thanks,
Chris.

--------------070103070701090606000204
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------070103070701090606000204--
