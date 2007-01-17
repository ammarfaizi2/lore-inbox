Return-Path: <linux-kernel-owner+w=401wt.eu-S1751726AbXAQBRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbXAQBRL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 20:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbXAQBRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 20:17:11 -0500
Received: from mail1.key-systems.net ([81.3.43.211]:33775 "HELO
	mail1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751418AbXAQBRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 20:17:11 -0500
Message-ID: <45AD7913.9010302@scientia.net>
Date: Wed, 17 Jan 2007 02:17:07 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Chris Wedgwood <cw@f00f.org>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel@vger.kernel.org, knweiss@gmx.de, andersen@codepoet.org,
       krader@us.ibm.com, lfriedman@nvidia.com, linux-nforce-bugs@nvidia.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8
 cpu errata needed?)
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <45AD2D00.2040904@scientia.net> <20070116203143.GA4213@tuatara.stupidest.org> <200701170829.54540.ak@suse.de>
In-Reply-To: <200701170829.54540.ak@suse.de>
Content-Type: multipart/mixed;
 boundary="------------090805060704010408030005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090805060704010408030005
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:
> AMD is looking at the issue. Only Nvidia chipsets seem to be affected,
> although there were similar problems on VIA in the past too.
> Unless a good workaround comes around soon I'll probably default
> to iommu=soft on Nvidia.
I've just read the posts about AMDs and NVIDIAs effort to find the
issue,... but in the meantime this would be the best solution.

And if "we"'ll ever find a rue solution,.. we could still deactivate the
iommu=soft setting.


Best wishes,
Chris.

--------------090805060704010408030005
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------090805060704010408030005--
