Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271286AbRHTPMt>; Mon, 20 Aug 2001 11:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271289AbRHTPMk>; Mon, 20 Aug 2001 11:12:40 -0400
Received: from www.casdn.neu.edu ([155.33.251.101]:2575 "EHLO
	www.casdn.neu.edu") by vger.kernel.org with ESMTP
	id <S271286AbRHTPM3>; Mon, 20 Aug 2001 11:12:29 -0400
From: "Andrew Scott" <A.J.Scott@casdn.neu.edu>
Organization: Northeastern University
To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 20 Aug 2001 11:12:27 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.8 aic7xxx -- continuous bus resets 
Reply-to: A.J.Scott@casdn.neu.edu
Message-ID: <3B80F09A.8507.A8DAED@localhost>
In-Reply-To: <200108170001.f7H01GI82362@aslan.scsiguy.com>
In-Reply-To: Your message of "Wed, 15 Aug 2001 16:04:25 EDT."             <3B7A9D88.23945.BFC66BE@localhost> 
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Aug 2001, at 18:01, Justin T. Gibbs wrote:

> >
> >I thought I'd look at the 2.4.8 kernel while I figure out what's 
> >wrong with my 2.2.18 installation. The kernel loading gets stuck with 
> >errors from the aic7xxx driver, which keeps timeing out querying the 
> >bus looking for non-existant drives, and when it finaly tries to 
> >query a drive that exists it claims to see bus errors. End result is 
> >that Linux 2.4.8 never mounts any drives or finishes loading.
> >
> >The system is an IBM 704 with a built in adaptec aic-7880U 
> >controller, with two drives on first scsi buss. 
> >
> >2.2.18 has no problems with the adaptec controllers, but has other 
> >issues, which seem to be timer related.
> 
> 2.4.9 has the latest aic7xxx driver in it.  Can you see if that changes
> things for you?  If not, can you hook up a serial console to the machine
> and provide all of the messages from an aic7xxx=verbose boot?

Ok, tried 2.4.9. With 1 ioapic the machine boots just fine. With the 
second ioapic enabled the behavior I previously described still 
occurs.

attempting to Queue abort
aic7xxx_abort returns 8194

These are the only error messages I copied down, I believe that there 
was another, will reboot and check later.




                      _
                     / \   / ascott@casdn.neu.edu
                    / \ \ /
                   /   \_/
