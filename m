Return-Path: <linux-kernel-owner+w=401wt.eu-S932095AbXAOXFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbXAOXFi (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 18:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbXAOXFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 18:05:38 -0500
Received: from mail1.key-systems.net ([81.3.43.211]:57612 "HELO
	mail1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932095AbXAOXFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 18:05:37 -0500
Message-ID: <45AC08B9.5020007@scientia.net>
Date: Tue, 16 Jan 2007 00:05:29 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel@vger.kernel.org, cw@f00f.org, knweiss@gmx.de, ak@suse.de,
       andersen@codepoet.org, krader@us.ibm.com, lfriedman@nvidia.com,
       linux-nforce-bugs@nvidia.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <459C3F29.2@shaw.ca> <45AC06B2.3060806@scientia.net>
In-Reply-To: <45AC06B2.3060806@scientia.net>
Content-Type: multipart/mixed;
 boundary="------------000707030504080105050507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000707030504080105050507
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sorry, as always I've forgot some things... *g*


Robert Hancock wrote:

> If this is related to some problem with using the GART IOMMU with memory 
> hole remapping enabled
What is that GART thing exactly? Is this the hardware IOMMU? I've always
thought GART was something graphics card related,.. but if so,.. how
could this solve our problem (that seems to occur mainly on harddisks)?

> then 2.6.20-rc kernels may avoid this problem on 
> nForce4 CK804/MCP04 chipsets as far as transfers to/from the SATA 
> controller are concerned
Does this mean that PATA is no related? The corruption appears on PATA
disks to, so why should it only solve the issue at SATA disks? Sounds a
bit strange to me?

> as the sata_nv driver now supports 64-bit DMA 
> on these chipsets and so no longer requires the IOMMU.
>   
Can you explain this a little bit more please? Is this a drawback (like
a performance decrease)? Like under Windows where they never use the
hardware iommu but always do it via software?


Best wishes,
Chris.

--------------000707030504080105050507
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------000707030504080105050507--
