Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317392AbSHPTZF>; Fri, 16 Aug 2002 15:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317396AbSHPTZF>; Fri, 16 Aug 2002 15:25:05 -0400
Received: from taco.vianet.on.ca ([209.91.128.11]:22434 "HELO smtp.vianet.ca")
	by vger.kernel.org with SMTP id <S317392AbSHPTZE>;
	Fri, 16 Aug 2002 15:25:04 -0400
Message-ID: <3D5D527E.5030607@thirddimension.net>
Date: Fri, 16 Aug 2002 15:29:02 -0400
From: Reid Sutherland <reid-lkml@thirddimension.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Interrupt issue with 2.4.19 vs 2.4.18.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I have a problem with the aic7xxx constantly retrying to initialize my 
LVD SCSI drives.  I'm repeatedly getting a "Command already completed" 
message.  It was mentioned to me that this might be an interrupt related 
problem (thank you Justin!).

My board has a Intel 440GX chipset.  From my understanding these are a 
bitch to deal with and are littered with bugs.  I've also read that by 
enabling SMP or IO-APIC, it should solve this issue.  Well, neither does 
it for me.

Does anyone know what could have changed between .18 and .19 that would 
cause something like this to happen?

Any insight would be appreciated!

Thanks,

-reid

