Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271987AbRIDRu0>; Tue, 4 Sep 2001 13:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272034AbRIDRuP>; Tue, 4 Sep 2001 13:50:15 -0400
Received: from jive.SoftHome.net ([204.144.231.93]:29901 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S271987AbRIDRuG>;
	Tue, 4 Sep 2001 13:50:06 -0400
From: "John L. Males" <jlmales@softhome.net>
Organization: Toronto, Ontario, Canada
To: Doug McNaught <doug@wireboard.com>
Date: Tue, 4 Sep 2001 13:49:51 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Question Re AC Patch with VM Tuneable Parms for now
Reply-to: jlmales@softhome.net
CC: linux-kernel@vger.kernel.org
Message-ID: <3B94DBFF.1248.396225@localhost>
In-Reply-To: "John L. Males"'s message of "Tue, 4 Sep 2001 02:30:08 -0500"
In-Reply-To: <m37kvfovbo.fsf@belphigor.mcnaught.org>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Doug,

Thanks for taking the time to reply and refreshing my memory about
menu oldconfig.

I imply from your reply that there is no carry forward feature via
the menu xconfig.  I guess it was wishful thinking in my original
message there might be.  Not an big issue, just thought I ask in case
I missed something in reading and searching the kernel doc.

Thanks for tip that the tuneable VM items may be implemented via
/proc.


Regards,

John L. Males
Willowdale, Ontario
Canada
04 September 2001 14:49
mailto:jlmales@softhome.net


To:             	jlmales@softhome.net
Copies to:      	linux-kernel@vger.kernel.org
Subject:        	Re: Question Re AC Patch with VM Tuneable Parms for
now
From:           	Doug McNaught <doug@wireboard.com>
Date sent:      	04 Sep 2001 10:59:55 -0400

> "John L. Males" <jlmales@softhome.net> writes:
> 
> > Can someone advise me if the "Make several vm behaviours tunable
> > for now" as of the 2.4.9-ac4 patch are implemented in the kernel
> > .config file?  If so is there an easy way to carry forward a
> > 2.4.8 version of the .config file using "make xconfig" so that I
> > do not have to set all the setting I have made from scratch?  I
> > get the sense from the Kernel documentation that one can run a
> > process that will ask one only those parameters that have been
> > changed or added rather that all of them, but best I can tell
> > this is a console y/n/?? type response.
> 
> You have to do the carry-forward on the command line, using 
> 'make oldconfig'.  It will prompt you to answer any questions that
> aren't in the old config file, which will usually be fairly few. 
> So it's not that bad, and you only have to do it once per upgrade.
> 
> Once you've done it, you can use 'menuconfig' as usual to tune your
> configuration.  
> 
> BTW, it's quite likely (though I haven't looked at it) that the
> VM tunables are in /proc rather than being config options.
> 
> -Doug
> -- 
> Free Dmitry Sklyarov! 
> http://www.freesklyarov.org/ 
> 
> We will return to our regularly scheduled signature shortly.


-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use 
<http://www.pgp.com>

iQA/AwUBO5UiNeAqzTDdanI2EQIPigCgoEPsa9QqvFPcZ/TbGZUPCxaLe20AnRN6
PJ60mqjFcKquI2lqGD4daWKb
=yLPc
-----END PGP SIGNATURE-----



"Boooomer ... Boom Boom, how are you Boom Boom" Boomer 1985 - February/2000
