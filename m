Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965188AbWBHC4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965188AbWBHC4U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 21:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965190AbWBHC4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 21:56:20 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:19684
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S965188AbWBHC4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 21:56:19 -0500
Message-ID: <43E95DD2.6000601@microgate.com>
Date: Tue, 07 Feb 2006 20:56:18 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Olaf Hering <olh@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new tty buffering locking fix
References: <200602032312.k13NCbWb012991@hera.kernel.org>	 <20060207123450.GA854@suse.de>	 <1139329302.3019.14.camel@amdx2.microgate.com>	 <20060207171111.GA15912@suse.de>	 <1139347644.3174.16.camel@amdx2.microgate.com> <1139361293.22595.14.camel@localhost.localdomain> <43E95A40.7010905@microgate.com>
In-Reply-To: <43E95A40.7010905@microgate.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum wrote:
> Alan Cox wrote:
> 
>> Thats going to hurt memory consumption in the worst cases.
> 
> I'll gather some accounting info tomorrow,
> and consider the more pathological cases.

Now that I think about it (ow!), there is a simple way
to cap the memory penalty to a single extra buffer allocation
and still maintain the existing interface behavior.

I'll post a new patch tomorrow.

Thanks,
Paul

--
Paul Fulghum
Microgate Systems, Ltd
