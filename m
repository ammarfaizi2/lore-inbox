Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbUCXTYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 14:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbUCXTYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 14:24:54 -0500
Received: from pop.gmx.net ([213.165.64.20]:35991 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263078AbUCXTYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 14:24:53 -0500
X-Authenticated: #4512188
Message-ID: <4061E081.7030701@gmx.de>
Date: Wed, 24 Mar 2004 20:24:49 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: zilvinas@gemtek.lt
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.5-rc2, hotplug and ohci-hcd issue
References: <Pine.LNX.4.58.0403191937160.1106@ppc970.osdl.org>	 <405C1B14.6000206@gmx.de> <20040320132334.GB13028@gemtek.lt>	 <405C979A.8070200@gmx.de>  <405CC7EC.9030205@gmx.de> <1079944371.2064.1.camel@swoop.gemtek.lt>
In-Reply-To: <1079944371.2064.1.camel@swoop.gemtek.lt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zilvinas Valinskas wrote:
> If you boot without any plugged USB devices and later on plug in USB
> devices things are working as expected. Something fishy about hotplug
> and perhaps in particular when OHCI and EHCI are initialized with USB
> devices connected.
> 

I found out that 2.6.5-rc2-mm2 at least works in terms of unloading the 
usb modules.

Prakash
