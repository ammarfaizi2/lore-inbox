Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315236AbSD2XOh>; Mon, 29 Apr 2002 19:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315237AbSD2XOg>; Mon, 29 Apr 2002 19:14:36 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:7352 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S315236AbSD2XOe>; Mon, 29 Apr 2002 19:14:34 -0400
Date: Mon, 29 Apr 2002 16:14:33 -0700 (PDT)
From: Jauder Ho <jauderho@carumba.com>
X-X-Sender: jauderho@twinlark.arctic.org
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'Andrew Theurer'" <habanero@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Hyperthreading and physical/logical CPU identification
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7DF0@orsmsx111.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0204291614100.6699-100000@twinlark.arctic.org>
X-Mailer: UW Pine 4.44 + a bunch of schtuff
X-There-Is-No-Hidden-Message-In-This-Email: There are no tyops either
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, you could always take CPUs out... :)

--Jauder

On Mon, 29 Apr 2002, Grover, Andrew wrote:

> > From: Andrew Theurer [mailto:habanero@us.ibm.com]
> > I would like to know if there is any way to confirm that I have
> > hyperthreading enabled, and my P4 CPUs are hyperthreaded.
> > Actually, from
> > something like /proc/cpuinfo, I'd like to figure out if I am
> > seeing 2/4
> > physical/logical processors, as a result from hyperthreading, or 4/4
> > physical/logical processors with no hyperthreading.  I know,
> > "If it's double
> > the number of physical processors, well you have
> > hyperthreading enabled."
> > The problem is, I have 4 physical processors, but kernel.org
> > kernels so far
> > do not recognize all of them.  2.4.18 will find 3, while
> > 2.5.11 will find
> > only 2 (BIOS hyperthreading support off, no acpismp=force).
> > However, on
> > 2.5.11, if I enable hyperthreading (thru BIOS and
> > acpismp=force, I see 4
> > processors.
> >
> > I would very much like to believe that in this configuration,
> > I am only
> > running on 2 physical, 4 logical processors, but I am getting a 31%
> > improvement (netbench) when hyperthreading is enabled.  Thats
> > why I want to
> > confirm I am really only using 2 physical, 4 logical
> > processors.  Is there
> > any way I can do this? (dmesg? /proc/cpuinfo?)
>
> Well the two alternatives are, either A) turning on hyperthreading enabled
> the two virtual processors or B) turning on hyperthreading somehow enabled
> the other two processors, right?
>
> I would think B would be highly unlikely.
>
> Anyone else who actually has HT hardware care to comment? ;-)
>
> Regards -- Andy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

