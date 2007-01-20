Return-Path: <linux-kernel-owner+w=401wt.eu-S965076AbXATBIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbXATBIJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 20:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbXATBIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 20:08:09 -0500
Received: from grayson.netsweng.com ([207.235.77.11]:47563 "EHLO
	grayson.netsweng.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965076AbXATBII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 20:08:08 -0500
X-Greylist: delayed 1687 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jan 2007 20:08:08 EST
Date: Fri, 19 Jan 2007 19:38:06 -0500 (EST)
From: Stuart Anderson <anderson@netsweng.com>
X-X-Sender: anderson@trantor.stuart.netsweng.com
To: Woody Suwalski <woodys@xandros.com>
cc: linux-fbdev-devel@lists.sourceforge.net, Martin Michlmayr <tbm@cyrius.com>,
       rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cyber2010 framebuffer on ARM Netwinder fix...
In-Reply-To: <45A3D05F.7060409@xandros.com>
Message-ID: <Pine.LNX.4.64.0701191937110.25957@trantor.stuart.netsweng.com>
References: <459D368F.2030204@xandros.com> <45A3D05F.7060409@xandros.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Just wondering, did the rtc change for the arm get sent up also?


On Tue, 9 Jan 2007, Woody Suwalski wrote:

> Martin Michlmayr wrote:
>> * Stuart Anderson <anderson@netsweng.com> [2007-01-05 09:40]:
>> 
>>> shark w/o any changes to the kernel. I dug a bit further, both in the
>>> driver, and in the HW spec for the shark, and discovered that the video
>>> chip on the shark is connected via the VL bus, not the PCI bus. The
>>> shark does have a VL-PCI bridge, but there doesn't seem to be anything
>>> connected to the PCI side of it (which matches what lspci says). The
>>> function containing the patch in question doesn't appear to even run on
>>> the shark (there is a VL version that is #ifdef SHARK'd), so I'd have
>>> to say the patch would have not impact on the shark.
>>> 
>> 
>> OK, good news.  Thanks for checking.  Woody, can you submit the patch
>> (with proper intentation) to linux-fbdev-devel@lists.sourceforge.net
>> 
>
> As suggested - I am sending this patch to fbdev-devel....
>
> The Netwinder machines with Cyber2010 crash badly when starting Xserver.
> The workaround is to disable pci burst option for this revision of video 
> chip.
>
> Thanks, Woody
>
>


                                 Stuart

Stuart R. Anderson                               anderson@netsweng.com
Network & Software Engineering                   http://www.netsweng.com/
1024D/37A79149:                                  0791 D3B8 9A4C 2CDC A31F
                                                  BD03 0A62 E534 37A7 9149
