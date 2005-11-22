Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965152AbVKVTrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbVKVTrT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbVKVTrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:47:19 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:13574 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S965152AbVKVTrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:47:18 -0500
Message-ID: <438375C1.40300@argo.co.il>
Date: Tue, 22 Nov 2005 21:47:13 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jeff Garzik <jgarzik@pobox.com>, Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Dave Airlie <airlied@gmail.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
References: <20051121225303.GA19212@kroah.com>	 <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>	 <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>	 <1132623268.20233.14.camel@localhost.localdomain>	 <1132626478.26560.104.camel@gaston>	 <9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com>	 <43833D61.9050400@argo.co.il> <20051122155143.GA30880@havoc.gtf.org>	 <43834400.3040506@argo.co.il> <20051122162506.GA32684@havoc.gtf.org>	 <438349F4.2080405@argo.co.il> <1132684739.20233.51.camel@localhost.localdomain>
In-Reply-To: <1132684739.20233.51.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2005 19:47:16.0751 (UTC) FILETIME=[8ACCD1F0:01C5EF9D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Maw, 2005-11-22 at 18:40 +0200, Avi Kivity wrote:
>  
>
>>However the situation with video drivers is already bad, and 
>>deteriorating. I had to hunt on the Internet to get my recent (FC4) 
>>distro to support my low-end embedded video (via). In the future it 
>>looks like even that won't work.
>>    
>>
>
>via should work open source. It didn't in the initial FC4 X but that was
>an X.org/RH bug and is fixed in the updates.
>
>  
>
It is not. It works with the vesa driver but you can count the scans at 
60Hz. I believe it is in rawhide now but I don't have test machines,

Originally reported here: 
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=156681.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

