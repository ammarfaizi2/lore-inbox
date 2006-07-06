Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbWGFKaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWGFKaQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 06:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWGFKaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 06:30:16 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:1097 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1030202AbWGFKaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 06:30:14 -0400
Message-ID: <44ACE75D.9030003@gentoo.org>
Date: Thu, 06 Jul 2006 11:35:09 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Daniel Bonekeeper <thehazard@gmail.com>
CC: Greg KH <greg@kroah.com>, Alon Bar-Lev <alon.barlev@gmail.com>,
       kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Driver for Microsoft USB Fingerprint Reader
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>	 <20060703222645.GA22855@kroah.com>	 <e1e1d5f40607031624w245e5f70g2ae8f5d0e9d357c4@mail.gmail.com>	 <20060703232927.GA19111@kroah.com>	 <e1e1d5f40607031704kec2ff68w324d3d8ad111c46b@mail.gmail.com>	 <44ABFDD3.6040500@gentoo.org>	 <e1e1d5f40607051109r3e01a2eftce93314228425612@mail.gmail.com>	 <44AC0B2A.9080500@gentoo.org>	 <e1e1d5f40607051246r4d583d9arab570b5a9e8cab0c@mail.gmail.com>	 <44AC49EE.1070104@gentoo.org> <e1e1d5f40607051905w4a755a35oa1c81666fd194c83@mail.gmail.com>
In-Reply-To: <e1e1d5f40607051905w4a755a35oa1c81666fd194c83@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Bonekeeper wrote:
> Do you currently have any page/doc/wiki about the current efforts in
> writing an API to handle fingerprint stuff ? (as in (3))

No, but feel free to use the dpfp wiki if you want to start one.

> Anyways, how idmouse got into the mainstream kernel, then ?

You are asking this because its usability is questionable?

Before you start on any of the more advanced code such as unified API 
and fingerprint recognition, you need the basic device support in place. 
The idmouse driver does this.

Greg is particularly keen on including semi-working driver code in the 
Linux kernel even if there is no complete picture, because it really 
raises awareness and development efforts. After all, if idmouse wasn't 
included because it doesn't form a complete fingerprint login system, 
I'd probably have never heard of it and would have no clue about it's 
capabilities.

Daniel

