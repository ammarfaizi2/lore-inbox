Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935763AbWLHJQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935763AbWLHJQs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 04:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938017AbWLHJQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 04:16:48 -0500
Received: from enyo.dsw2k3.info ([195.71.86.239]:55934 "EHLO enyo.dsw2k3.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935763AbWLHJQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 04:16:47 -0500
Message-ID: <45792D74.5000901@citd.de>
Date: Fri, 08 Dec 2006 10:16:36 +0100
From: Matthias Schniedermeyer <ms@citd.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: single bit errors on files stored on USB-HDDs via USB2/usb_storage
References: <Pine.LNX.4.44L0.0612071306180.3537-100000@iolanthe.rowland.org>	<45786E58.5070308@citd.de> <20061207154545.6eb516c4.zaitcev@redhat.com>
In-Reply-To: <20061207154545.6eb516c4.zaitcev@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> On Thu, 07 Dec 2006 20:41:12 +0100, Matthias Schniedermeyer <ms@citd.de> wrote:
> 
> 
>>>>I'm using a Bunch auf HDDs in USB-Enclosures for storing files.
>>>>(currently 38 HDD, with a total capacity of 9,5 TB of which 8,5 TB is used)
>>>>[....]
>>>>This time i kept the defective files and used "vbindiff" to show me the
>>>>difference. Strangly in EVERY case the difference is a single bit in a
>>>>sequence of "0xff"-Bytes inside a block of varing bit-values that
>>>>changed a "0xff" into a "0xf7".
> 
> 
>>>This was almost certainly caused by hardware flaws in the USB interface 
>>>chips of the enclosures.  There's nothing the kernel can do about it 
>>>because the errors aren't reported; all that happens is that incorrect 
>>>data is sent to or from the drive.
>>
>>So pretty much all ich can do is to pray that the errors don't corrupt
>>the Filesystem-Metadata (XFS).
> 
> 
> No, this is not all. You should buy a variety of different enclosures
> with different chipsets (e.g. find a Freecom if you can),

That would definetly cost way to much money and time to be in any way
"efficient".

> and also use decent cables.

I replaced all cables with "High Quality"-cables.
But as a "Joe user" it is practically impossible to really know if the
cables are good.
All i can say is that the "original" cables that came with the
enclosures appear a bit thin and the ones i bought appear much more
thick, have gold plated contacts and have a massive plaited shielding
IOW appear much more trustworthy. But, as i said, in the end i can't
really know if they are better than the original ones.




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.

