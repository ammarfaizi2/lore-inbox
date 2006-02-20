Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWBTKPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWBTKPj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWBTKPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:15:39 -0500
Received: from canadatux.org ([81.169.162.242]:38869 "EHLO
	zoidberg.canadatux.org") by vger.kernel.org with ESMTP
	id S964837AbWBTKPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:15:38 -0500
Date: Mon, 20 Feb 2006 11:15:32 +0100
From: Matthias Hensler <matthias@wspse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Pavel Machek <pavel@suse.cz>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220101532.GB21817@kobayashi-maru.wspse.de>
Reply-To: Matthias Hensler <matthias@wspse.de>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602091926.38666.nigel@suspend2.net> <20060209232453.GC3389@elf.ucw.cz> <200602110116.57639.sebas@kde.org> <20060211104130.GA28282@kobayashi-maru.wspse.de> <20060218142610.GT3490@openzaurus.ucw.cz> <20060220093911.GB19293@kobayashi-maru.wspse.de> <1140430002.3429.4.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1140430002.3429.4.camel@mindpipe>
Organization: WSPse (http://www.wspse.de/)
X-Gummibears: Bouncing here and there and everywhere
X-Face: &Tv]9SsNpb/$w8\G-O%>W02aApFW^P>[x+Upv9xQB!2;iD9Y1-Lz'qlc{+lL2Y>J(u76Jk,cJ@$tP2-M%y?^'jn2J]3C'ss_~"u?kA^X&{]h?O?@*VwgSGob73I9r}&S%ktup0k2!neScg3'HO}PU#Ac>jwNL|P@f|f*sz*cP'hi)/<JQC4|Q[$D@aQ"C{$>a=6.rc-P1vXarjVXlzClmNfcSy/$4tQz
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, Feb 20, 2006 at 05:06:42AM -0500, Lee Revell wrote:
> On Mon, 2006-02-20 at 10:39 +0100, Matthias Hensler wrote:
> > These "big changes" is something I have a problem with, since it
> > means to delay a working suspend/resume in Linux for another
> > "short-term" (so what does it mean: 1 month? six? twelve?). It is
> > painful to get these things to work reliable, I have followed this
> > for nearly 1.5 years.  And again: today there is a working
> > implementation, so why not merge it and have something today, and
> > then start working on the other things. 
> 
> It never works that way in practice - if you let broken/suboptimal
> code into the kernel then it's a LOT less likely to get fixed later
> than if you make fixing it a condition of inclusion because once it's
> in there's much less motivation to fix it.

Isn't this what happend with swusp? I tried it of a period of time when
it was included in mainline, it was just buggy and nothing much
improved.

I totally agree with you that nothing broken should be get into
mainline, but I think that Suspend 2 has be proven to be stable, and it
is worth to put work on it and to fix the remaining issues instead of
just starting from the scratch.

Regards,
Matthias
