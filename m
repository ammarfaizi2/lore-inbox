Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132595AbRDQNAi>; Tue, 17 Apr 2001 09:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132604AbRDQNA3>; Tue, 17 Apr 2001 09:00:29 -0400
Received: from relay.freedom.net ([207.107.115.209]:17424 "HELO relay")
	by vger.kernel.org with SMTP id <S132595AbRDQNAL>;
	Tue, 17 Apr 2001 09:00:11 -0400
X-Freedom-Envelope-Sig: linux-kernel@vger.kernel.org AQF+qYQWL+poCAkiwOPeAKohobsTPpAnr/SU0K/8ToqomYMNiUKJ3KNx
Date: Tue, 17 Apr 2001 06:58:54 -0600
Old-From: cacook@freedom.net
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: DPT PM3755F Fibrechannel Host Adapter
Content-Type: text/plain; charset = "us-ascii" 
Content-Transfer-Encoding: 7bit
From: cacook@freedom.net
Message-Id: <20010417130019Z132595-682+791@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So no one is willing or able to help me with this problem?  I have invested much time and effort toward switching from Win2k to Linux, but if I can't get fibrechannel working it's not going to happen.

Applying the patch & compiling went fine.  But the new kernel doesn't recognize the FC host adapter (though the bios does) and there is no dpt_i20 module so I can't insmod.  I don't know how to tell whether the driver is in the kernel.  Maybe I'm just not smart enough for Linux.

ver_linux 
Linux hydra.darkmatter.com 2.4.2-0.1.49 #1 Sun Apr 15 18:12:33 MDT 2001 i686
unknown 

Gnu C                  2.96 
Gnu make               3.79.1 
binutils               2.10.91.0.2 
util-linux             2.10r 
modutils               2.4.2 
e2fsprogs              1.19 
reiserfsprogs          3.x.0b 
PPP                    2.4.0 
isdn4k-utils           3.1pre1 
Linux C Library        2.2.2 
Dynamic linker (ldd)   2.2.2 
Procps                 2.0.7 
Net-tools              1.57 
Console-tools          0.3.3 
Sh-utils               2.0 
Modules Loaded         via82cxxx_audio ac97_codec binfmt_misc autofs
nls_iso8859-1 nls_cp437 



-------- Original Message --------
Subject: Re: DPT PM3755F Fibrechannel Host Adapter
Date: Mon, 16 Apr 2001 08:51:57 -0600
From: cacook@freedom.net
To: Marko Kreen <marko@l-t.ee>
CC: linux-kernel@vger.kernel.org
In-Reply-To: <20010414233426Z131976-682+268@vger.kernel.org> <20010415020433.B13190@l-t.ee>

Thank you Marko.  This was exactly what I was looking for.  And thank you very much Omar Kilani for the retrofit.  But kernel doesn't recognize the adapter.

Installed the patch, compiled, installed, & everything seemed to go fine.  Booted to IDE... no problems, except the DPT HA wasn't recognized.  There was no mention of the DPT in messages, either recognized as hardware, nor to load the driver.

I am running an MSI KT7Turbo mobo with Athlon 850.  Six PCI & no IDE.  DPT PM3755F fibrechannel host adapter is in the first slot & has two Cheetahs attached.  Outfit works fine in Winders2k.  Trying to move to kernel 2.4.2, in RedHat Wolverine.

Please help.
--
C.

The best way out is always through.
      - Robert Frost  A Servant to Servants, 1914


Marko Kreen wrote:

> On Sat, Apr 14, 2001 at 05:33:02PM -0600, cacook@freedom.net wrote:
> > I have been unable to set up a module for my DPT fibrechannel host adapter, partly through unavailability, and partly through inexperience.
>
> There is a nice suppary of current DPT driver status on Kernel
> Traffic #113:
>
> http://kt.zork.net/kernel-traffic/kt20010330_113.html#3
>
> --
> marko
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
