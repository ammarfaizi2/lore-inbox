Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319234AbSIFQqq>; Fri, 6 Sep 2002 12:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319242AbSIFQqq>; Fri, 6 Sep 2002 12:46:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55826 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319234AbSIFQqp>;
	Fri, 6 Sep 2002 12:46:45 -0400
Message-ID: <3D78DCE9.5040808@mandrakesoft.com>
Date: Fri, 06 Sep 2002 12:50:49 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jordan Crouse <jordanc@censoft.com>
CC: Theewara Vorakosit <g4465018@pirun.ku.ac.th>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: VIA82cxxx sound problem
References: <Pine.GSO.4.44.0209061822580.1094-100000@pirun.ku.ac.th> <20020906092705.7a746d39.jordanc@censoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Crouse wrote:
>>Dear All,
>>	I use Gigabyte GA-7VTXE+, equip with on board sound card. When I
>>use sound card (when start KDE), there is a lot of message:
>>
>>via82cxxx warning: SG stopped or paused
>>
>>I'm using kernel 2.4.18-3, Red Hat 7.3. Would you please tell me how to solve this problem?
> 
> 
> You motherboard has a VA8233A south bridge, which is more fully supported in 2.4.19 than in the Red Hat kernel.  Upgrade, and your problems should go away (or at least, get easier to debug).


The newer multi-channel VT8233A audio chip isn't supported at all in the 
2.4.x via audio driver, you need ALSA for that support.  The VT8233A is 
_almost_ register compatible, but not enough to not require additional 
changes.

	Jeff



