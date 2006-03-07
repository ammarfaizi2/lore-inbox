Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752087AbWCGIWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbWCGIWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 03:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752096AbWCGIWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 03:22:47 -0500
Received: from cernmx03.cern.ch ([137.138.166.166]:2592 "EHLO cernmxlb.cern.ch")
	by vger.kernel.org with ESMTP id S1752087AbWCGIWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 03:22:46 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws; s=beta; d=cern.ch; q=dns; 
	h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding;
	b=G1GOn9VSLddsb611DO1Be8MYU1GogY9BDGHxncAqkb5anUljaJ5EOifDIYVp0dxjeXXy0wgIrM2lWdCqGknd5140I2f9NFZp8WBqQITjilLR/7+yvD9+xfIRqG8VLhG1;
Keywords: CERN SpamKiller Note: -51 Charset: west-latin
X-Filter: CERNMX03 CERN MX v2.0 051110.1345 Release
Message-ID: <440D42D9.7000604@cern.ch>
Date: Tue, 07 Mar 2006 09:22:49 +0100
From: Jiri Tyr <jiri.tyr@cern.ch>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060128)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mchehab@brturbo.com.br, video4linux-list@redhat.com, skinkie@xs4all.nl
Subject: Re: PROBLEM: four bttv tuners in one PC crashed
References: <440C5672.7000009@cern.ch> <200603061656.18846.duncan.sands@math.u-psud.fr>
In-Reply-To: <200603061656.18846.duncan.sands@math.u-psud.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2006 08:22:41.0616 (UTC) FILETIME=[4D7C5D00:01C641C0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan de Konink wrote:

>>I have removed all unnecessary things from kernel. Libata I need for
>>SATA disk. Do you think that is some possibility how to make this four
>>bttv tuners working?
>>
>What is your CONFIG_HZ setting? (100/250/1000 Hz)
>  
>

I'm using CONFIG_HZ=250. I have tryed also CONFIG_HZ=100, but it didn't
helped.

Ihave tryed to remove one of the four tuners and now I have no shared 
IRQ, but the PC still freeze. It is bug in DMA or whats wrong?

Jiri

