Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753838AbWKMDX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbWKMDX6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 22:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753841AbWKMDX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 22:23:58 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:1922 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S1753838AbWKMDX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 22:23:58 -0500
Message-ID: <4557E549.1080506@scientia.net>
Date: Mon, 13 Nov 2006 04:23:53 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: unexplainable read errors, copy/diff-issue
References: <4553DD90.1090604@scientia.net> <20061110135649.16cccca0.vsu@altlinux.ru>
In-Reply-To: <20061110135649.16cccca0.vsu@altlinux.ru>
Content-Type: multipart/mixed;
 boundary="------------020608000100030904070306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020608000100030904070306
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I may have probably found the bug,.. or at least some valuable
information about it.
It seems like it's actually the DMA who is responsible for the errors.

Until now I've completed 3 rund where I validated all files via their
sha512 sums,... and no errors were found.
I did this only on the PATA drives,... not yet on the SATA drives (and
remember, the issue happened on both drive types)

1) How do I deactivate DMA for an SATA drive?
2) How can I find out definitely if Windows uses DMA for a drive or not.
The hardware management shows for the primary IDE controller an
activated DMA. But the diff was so slow under Windows, that I assume
that this may be wrong.

Does this give you any further idea about the possible reason for the
issue? Is it possible a driver error (for that specific chipsets)? Or
hardware error?
Or can I try any other things?

Thanks and best wishes,
Chris.

--------------020608000100030904070306
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------020608000100030904070306--
