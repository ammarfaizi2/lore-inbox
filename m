Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVBORbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVBORbO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 12:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVBOR3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 12:29:00 -0500
Received: from fire.osdl.org ([65.172.181.4]:21943 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261807AbVBORZE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 12:25:04 -0500
Message-ID: <42123050.1040601@osdl.org>
Date: Tue, 15 Feb 2005 09:24:32 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: sergio@sergiomb.no-ip.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and	give	dev=/dev/hdX
 as device
References: <1108426832.5015.4.camel@bastov>	 <1108434128.5491.8.camel@bastov>  <42115DA2.6070500@osdl.org> <1108486952.4618.10.camel@localhost.localdomain>
In-Reply-To: <1108486952.4618.10.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2005-02-15 at 02:25, Randy.Dunlap wrote:
> 
>>It means:  don't use the ide-scsi driver.  Support for it is
>>lagging (not well-maintained) because it's really not needed for
>>burning CDs.  Just use the ide-cd driver (module) and
>>specify the CD burner device as /dev/hdX.
> 
> 
> This information is unfortunately *WRONG*. The base 2.6 ide-cd driver is
> vastly inferior to ide-scsi. The ide-scsi layer knows about proper error
> reporting, end of media and other things that ide-cd does not.
> 
> The -ac ide-cd knows some of the stuff that ide-cd needs to and works
> with various drive/disk combinations the base code doesn't but ide-scsi
> still handles CD's better.
> 
> Alan

Thanks for the corrections, Alan.

-- 
~Randy
