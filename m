Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317299AbSFHDTD>; Fri, 7 Jun 2002 23:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317375AbSFHDTC>; Fri, 7 Jun 2002 23:19:02 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:43276 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S317299AbSFHDTB>; Fri, 7 Jun 2002 23:19:01 -0400
Message-Id: <200206080315.g583Fj957513@aslan.scsiguy.com>
To: Patrick Mansfield <patmans@us.ibm.com>
cc: linux-kernel@vger.kernel.org, Shane Walton <dsrelist@yahoo.com>
Subject: Re: Stream Lined Booting - SCSI Hold Up 
In-Reply-To: Your message of "Fri, 07 Jun 2002 15:55:31 PDT."
             <20020607155531.A13335@eng2.beaverton.ibm.com> 
Date: Fri, 07 Jun 2002 21:15:45 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Jun 06, 2002 at 01:44:19PM -0700, Patrick Mansfield wrote:
>
>> On my system, it saves me about 10 seconds to boot with:
>> 
>> lilo: linux-1 aic7xxx=no_reset aic7xxx=seltime:3
>> 
>
>BTW, the above results in an infinite loop on shutdown, as the aic
>driver adds a reboot callback for each "aic7xxx=" option, pointing
>to static data, and ends up getting linked on a list pointing to
>itself.

You're using an old version of the driver then.  6.2.8 is the
latest.

--
Justin
