Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317399AbSGIUUZ>; Tue, 9 Jul 2002 16:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317398AbSGIUUY>; Tue, 9 Jul 2002 16:20:24 -0400
Received: from [199.128.236.1] ([199.128.236.1]:33810 "EHLO
	intranet.reeusda.gov") by vger.kernel.org with ESMTP
	id <S317399AbSGIUUW>; Tue, 9 Jul 2002 16:20:22 -0400
Message-ID: <630DA58AD01AD311B13A00C00D00E9BC05D20218@CSREESSERVER>
From: "Martinez, Michael - CSREES/ISTM" <MMARTINEZ@intranet.reeusda.gov>
To: "'jbradford@dial.pipex.com'" <jbradford@dial.pipex.com>,
       "Martinez, Michael - CSREES/ISTM" <MMARTINEZ@intranet.reeusda.gov>
Cc: linux-kernel@vger.kernel.org
Subject: RE: list of compiled in support
Date: Tue, 9 Jul 2002 16:23:45 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or maybe:

strings /proc/kernel/ksyms | grep ipx

Michael Martinez
System Administrator (Contractor)
Information Systems and Technology Management
CSREES - United States Department of Agriculture
(202) 720-6223


-----Original Message-----
From: jbradford@dial.pipex.com [mailto:jbradford@dial.pipex.com]
Sent: Tuesday, July 09, 2002 9:30 AM
To: MMARTINEZ@intranet.reeusda.gov
Cc: linux-kernel@vger.kernel.org
Subject: Re: list of compiled in support


Can't you just

grep ipx System.map

???  Or am I being thick again?  :-/

> No, no. Just simply find out whether my kernel supports ipx. And if it
does
> support it, then to disable it, without recompiling the kernel, perhaps by
> removing ipx entries from /etc/services.
> 
> Michael Martinez
> System Administrator (Contractor)
> Information Systems and Technology Management
> CSREES - United States Department of Agriculture
> (202) 720-6223
> 
> 
> -----Original Message-----
> From: Thunder from the hill [mailto:thunder@ngforever.de]
> Sent: Tuesday, July 09, 2002 8:53 AM
> To: Martinez, Michael - CSREES/ISTM
> Cc: 'Alan Cox'; linux-kernel@vger.kernel.org
> Subject: RE: list of compiled in support
> 
> 
> Hi,
> 
> On Tue, 9 Jul 2002, Martinez, Michael - CSREES/ISTM wrote:
> > Okay. this would require a little C code right? is there a shell command
> > line tool I could use instead?
> 
> What exactly is your intention? IPX networking from a shell script?
> 
> 							Regards,
> 							Thunder
> -- 
> (Use http://www.ebb.org/ungeek if you can't decode)
> ------BEGIN GEEK CODE BLOCK------
> Version: 3.12
> GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
> N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
> e++++ h* r--- y- 
> ------END GEEK CODE BLOCK------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
