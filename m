Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317431AbSFROif>; Tue, 18 Jun 2002 10:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317432AbSFROie>; Tue, 18 Jun 2002 10:38:34 -0400
Received: from [195.63.194.11] ([195.63.194.11]:26630 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317431AbSFROie> convert rfc822-to-8bit; Tue, 18 Jun 2002 10:38:34 -0400
Message-ID: <3D0F45E7.3050605@evision-ventures.com>
Date: Tue, 18 Jun 2002 16:38:31 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Garet Cammer <arcolin@arcoide.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Need IDE Taskfile Access
References: <004701c216cf$efd1ca60$8201a8c0@arcoi0s17j2t0x>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Garet Cammer napisa³:
> For some time now we have been writing user applications that send ATAPI 
> commands to the IDE bus to initialize and configure our hardware RAID 1 
> controllers. This has been working well, thanks to Andre's patch that 
> gave us taskfile access through the ioctl API. We were counting on it to 
> be a permanent part of the 2.5/2.6 kernel, since there is a lot of 
> hardware in the field using these apps.
> Imagine our surprise when we discovered that taskfile access was being 
> abandoned completely!
> Although we understand that the kernel may need to filter some commands, 
> why can't applications access at least the Smart commands? Help!
> Regards,
> Garet Cammer
> Software Development
> Arco Computer Products
> (954) 925-2688

ATAPI is no problem. You can use the whole SCSI layer on top of
ide-scsi.





