Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWCASbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWCASbz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 13:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWCASbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 13:31:55 -0500
Received: from rtr.ca ([64.26.128.89]:60854 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750775AbWCASby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 13:31:54 -0500
Message-ID: <4405E8AA.1090803@rtr.ca>
Date: Wed, 01 Mar 2006 13:32:10 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Douglas Gilbert <dougg@torque.net>, Mark Rustad <mrustad@mac.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sg regression in 2.6.16-rc5
References: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com> <4404AA2A.5010703@torque.net> <20060301083824.GA9871@merlin.emma.line.org> <Pine.LNX.4.64.0603011027400.22647@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603011027400.22647@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 1 Mar 2006, Matthias Andree wrote:
>> On Tue, 28 Feb 2006, Douglas Gilbert wrote:
>>
>>> You can stop right there with the 1 MB reads. Welcome
>>> to the new, blander sg driver which now shares many
>>> size shortcomings with the block subsystem.
>> What is the reason to break user-space applications like this?
> 
> Did you read the whole thread? It was a low-level SCSI driver issue, where 
> nothing broke user space, but the command was just fed to the drive 
> differently, which then hit a limit in the driver.

Will this break major applications like CD/DVD rippers,
DVD players, etc.. which read LARGE blocks at a time?

If not, then good!
