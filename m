Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271335AbRH1PCJ>; Tue, 28 Aug 2001 11:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271307AbRH1PB7>; Tue, 28 Aug 2001 11:01:59 -0400
Received: from thunderchild.ikk.sztaki.hu ([193.225.87.24]:51205 "HELO
	thunderchild.ikk.sztaki.hu") by vger.kernel.org with SMTP
	id <S271278AbRH1PBm>; Tue, 28 Aug 2001 11:01:42 -0400
Date: Tue, 28 Aug 2001 17:01:59 +0200
From: Gergely Madarasz <gorgo@thunderchild.debian.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7899 problems
Message-ID: <20010828170159.O6202@thunderchild.ikk.sztaki.hu>
In-Reply-To: <20010828145526.I6202@thunderchild.ikk.sztaki.hu> <200108281458.f7SEwSY89672@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <200108281458.f7SEwSY89672@aslan.scsiguy.com>; from gibbs@scsiguy.com on Tue, Aug 28, 2001 at 08:58:28AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2001 at 08:58:28AM -0600, Justin T. Gibbs wrote:
> >Hello,
> >
> >the error message is like this:
> >
> >scsi0:0:3:0: Attempting to queue an ABORT message
> >scsi0:0:3:0: Cmd aborted from QINFIFO
> >aic7xxx_abort returns 8194
> >
> >lots of these messages. the same happens on scsi0:0:4:0, scsi0:0:5:0 and
> >scsi0:0:9:0, then I get ext2 and I/O errors. I have 4 of these machines
> >(ibm netfinity 5100), running for several weeks now as http proxies, and
> >sometimes they crash (3 from 4 have crashed so far at least once, this is
> >the first time I have logs from the beginning of the crash). The kernel is
> >stock 2.4.7. On another machine (netfinity 7100, aic7896) I couldn't boot
> >stock 2.4.9 because I got these messages right after the boot, the old aic
> >driver worked though. I'm puzzled because the 5100's worked perfectly for
> >almost a month. What should I try? 
> 
> Please boot a 2.4.9 system with "aic7xxx=verbose" in your lilo.conf
> (aic7xxx driver statically linked into your kernel", or:
> 
> options aic7xxx aic7xxx=`"verbose"'
> 
> in your modules.conf (you'll have to recreate the initrd for it
> to take effect) if you are loading a module.  Use a serial console
> to capture all messages from the start of boot through several
> reported errors, and send it to me.

I'll try but days or weeks might pass before the next crash occurs.
Thanks.

-- 
Madarasz Gergely   gorgo@thunderchild.debian.net   gorgo@linux.rulez.org
    It's practically impossible to look at a penguin and feel angry.
        Egy pingvinre gyakorlatilag lehetetlen haragosan nezni.
                  HuLUG: http://mlf.linux.rulez.org/
