Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313613AbSDKP2c>; Thu, 11 Apr 2002 11:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313932AbSDKP2b>; Thu, 11 Apr 2002 11:28:31 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:27146 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S313613AbSDKP2a>;
	Thu, 11 Apr 2002 11:28:30 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Ted Deppner <ted@psyber.com>
Date: Thu, 11 Apr 2002 17:27:29 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: New IDE code and DMA failures
CC: Jens Axboe <axboe@suse.de>, Martin Dalecki <martin@dalecki.de>,
        Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
        vda@port.imtp.ilyichevsk.odessa.ua
X-mailer: Pegasus Mail v3.50
Message-ID: <2126B5B63EE@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Apr 02 at 6:05, Ted Deppner wrote:
> On Thu, Apr 11, 2002 at 03:39:33PM -0200, Denis Vlasenko wrote:
> > I have a flaky IDE subsystem in one box. Reads work fine,
> > writes sometimes don't work and hang either IDE/block device
> > 
> > Please inform me whenever you want me to test your patches.
> 
> I've been testing 2.4.17 and 2.4.19-pre6 and see some similar issues.  I
> have an Asus A7V w/ 1gig Athlon processor.  Using the onboard Promise
> UDMA100 controller, I can read and write all day long to /dev/hde all by
> itself...  However, after few minutes of any type of access to /dev/hdh,
> /dev/hde suddenly starts having DMA errors and switches to PIO.  I'm on my
> third DMA66 cable (yet it fights tightly), and am still seeing the exact
> same issues.  I don't believe my IDE subsystem to be flaky.  hde is a WD
> drive, and hdh is a Maxtor.

What your /dev/hdg is? Using slave-alone on the A7V's Promise (and maybe
on other motherboards too) will corrupt your disk badly. Under Linux,
and also under Windows98. I did not tried other OSes...
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
