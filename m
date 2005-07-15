Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVGON30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVGON30 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 09:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbVGON3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 09:29:25 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:58055 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261914AbVGON3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 09:29:24 -0400
Message-ID: <42D7BA2F.9070505@brturbo.com.br>
Date: Fri, 15 Jul 2005 10:29:19 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Patrick Boettcher <patrick.boettcher@desy.de>
CC: Andrew Benton <b3nt@ukonline.co.uk>, Johannes Stezenbach <js@linuxtv.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Michael Krufky <mkrufky@m1k.net>, video4linux-list@redhat.com
Subject: Re: cx22702.c, 2.6.13-rc3 and a pci Hauppauge Nova-T DVB-T TV card
References: <42D77E37.5010908@ukonline.co.uk> <20050715110938.GB9976@linuxtv.org> <Pine.LNX.4.61.0507151308450.15841@pub2.ifh.de> <42D7B2A0.2040301@ukonline.co.uk> <Pine.LNX.4.61.0507151459180.15841@pub2.ifh.de>
In-Reply-To: <Pine.LNX.4.61.0507151459180.15841@pub2.ifh.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick,

Patrick Boettcher wrote:
> On Fri, 15 Jul 2005, Andrew Benton wrote:
> 
>> Hi, I tried the patch but unfortunately the kernel didn't compile, it
>> ended like this
>>
>> CC      drivers/media/video/cx88/cx88-blackbird.o
>> CC      drivers/media/video/cx88/cx88-dvb.o
>> drivers/media/video/cx88/cx88-dvb.c:169: error: unknown field
>> `output_mode' specified in initializer
>> drivers/media/video/cx88/cx88-dvb.c:176: error: unknown field
>> `output_mode' specified in initializer
> 
> 
> Yes, I was in a hurry *slap* and made a mistake.
> 
> This one is correct (revert the other one):

	I've already included this on V4L tree.

	On V4L, we do provide support for older 2.6 releases (so, we have some
ifdefs to provide backport compatibility that are removed by a script
before submiting patchsets).
	If I understand well your patch, it is to be applied after 2.6.12
version. Am I right?

Mauro.
