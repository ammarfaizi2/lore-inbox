Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269002AbRHQABU>; Thu, 16 Aug 2001 20:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269158AbRHQABK>; Thu, 16 Aug 2001 20:01:10 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:13840 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S269002AbRHQABF>; Thu, 16 Aug 2001 20:01:05 -0400
Message-Id: <200108170001.f7H01GI82362@aslan.scsiguy.com>
To: A.J.Scott@casdn.neu.edu
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8 aic7xxx -- continuous bus resets 
In-Reply-To: Your message of "Wed, 15 Aug 2001 16:04:25 EDT."
             <3B7A9D88.23945.BFC66BE@localhost> 
Date: Thu, 16 Aug 2001 18:01:16 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I thought I'd look at the 2.4.8 kernel while I figure out what's 
>wrong with my 2.2.18 installation. The kernel loading gets stuck with 
>errors from the aic7xxx driver, which keeps timeing out querying the 
>bus looking for non-existant drives, and when it finaly tries to 
>query a drive that exists it claims to see bus errors. End result is 
>that Linux 2.4.8 never mounts any drives or finishes loading.
>
>The system is an IBM 704 with a built in adaptec aic-7880U 
>controller, with two drives on first scsi buss. 
>
>2.2.18 has no problems with the adaptec controllers, but has other 
>issues, which seem to be timer related.

2.4.9 has the latest aic7xxx driver in it.  Can you see if that changes
things for you?  If not, can you hook up a serial console to the machine
and provide all of the messages from an aic7xxx=verbose boot?

Thanks,
Justin
