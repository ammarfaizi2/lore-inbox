Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314166AbSDMBCe>; Fri, 12 Apr 2002 21:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314167AbSDMBCd>; Fri, 12 Apr 2002 21:02:33 -0400
Received: from c5cust8.starstream.net ([206.170.161.8]:32900 "HELO
	10cust182.starstream.net") by vger.kernel.org with SMTP
	id <S314166AbSDMBCc>; Fri, 12 Apr 2002 21:02:32 -0400
Date: Fri, 12 Apr 2002 18:02:30 -0700
From: Ted Deppner <ted@psyber.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Ted Deppner <ted@psyber.com>, Jens Axboe <axboe@suse.de>,
        Martin Dalecki <martin@dalecki.de>, Vojtech Pavlik <vojtech@suse.cz>,
        linux-kernel@vger.kernel.org, vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: New IDE code and DMA failures
Message-ID: <20020413010230.GB17025@dondra.ofc.psyber.com>
Reply-To: Ted Deppner <ted@psyber.com>
Mail-Followup-To: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	Ted Deppner <ted@psyber.com>, Jens Axboe <axboe@suse.de>,
	Martin Dalecki <martin@dalecki.de>,
	Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
	vda@port.imtp.ilyichevsk.odessa.ua
In-Reply-To: <2126B5B63EE@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 05:27:29PM +0100, Petr Vandrovec wrote:
> What your /dev/hdg is? Using slave-alone on the A7V's Promise (and maybe
> on other motherboards too) will corrupt your disk badly. Under Linux,
> and also under Windows98. I did not tried other OSes...

I did not have a /dev/hdg.  I searched and found your emails to
linux-kernel regarding your findings on quirks with the PDC20265
controller and moved /dev/hdh to /dev/hdg 

I've not had a single DMA error since, regardless of how much I've tried
to break things.  Previously I was able to fail things within a few
minutes.

Thank you!

At this point I am racking these issues against hardware quirks of my
A7V's onboard controller... I cannot say that there is anything amiss in
the kernel (or with reiserfs) in the light these findings.

-- 
Ted Deppner
http://www.psyber.com/~ted/
