Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161840AbWKIU7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161840AbWKIU7L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 15:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161843AbWKIU7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 15:59:11 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:15060 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S1161840AbWKIU7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 15:59:09 -0500
Message-ID: <45539699.40105@scientia.net>
Date: Thu, 09 Nov 2006 21:59:05 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Roger Heflin <rheflin@atipa.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange write errors on FAT32 partition (maybe an FAT32 bug?!)
References: <4550A481.2010408@scientia.net> <87psbzrss2.fsf@duaron.myhome.or.jp> <4553744E.3050007@scientia.net> <45539188.5080607@atipa.com> <45539366.7070809@scientia.net> <45539588.7020504@atipa.com>
In-Reply-To: <45539588.7020504@atipa.com>
Content-Type: multipart/mixed;
 boundary="------------050006080400050507050809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050006080400050507050809
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Roger Heflin wrote:
> The failure can manifest itself in many ways, I have
> only seen it as a read failure, but there should be no
> reason why it cannot also show as a write failure.
>
> It should be in the later vanilla kernels, it won't
> be in the earlier ones,  I would do a
> find /lib/modules -name "*edac*" -ls
>
> It is a hw issue, either something is running faster that
> it should be (pci bus set to fast for the given hardware/config)
> or something is broken.
The strange thing is that it always occures on the copied data,.. not
the original (which is on another disk). But wouldn those parity errors
not occur in general?
For example al my sha1sums -c sumfile checks are working corretly on the
original disk :/

--------------050006080400050507050809
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------050006080400050507050809--
