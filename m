Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbTCRSdz>; Tue, 18 Mar 2003 13:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262530AbTCRSdz>; Tue, 18 Mar 2003 13:33:55 -0500
Received: from brynhild.mtroyal.ab.ca ([142.109.10.24]:48544 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S262528AbTCRSdv>; Tue, 18 Mar 2003 13:33:51 -0500
Date: Tue, 18 Mar 2003 11:44:11 -0700 (MST)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Tomas Szepe <szepe@pinerecords.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Neale Banks <neale@lowendale.com.au>
Subject: re: Ptrace hole / Linux 2.2.25
In-Reply-To: <Pine.LNX.4.05.10303180613040.29730-100000@marina.lowendale.com.au>
Message-ID: <Pine.LNX.4.51.0303181139210.16281@skuld.mtroyal.ab.ca>
References: <Pine.LNX.4.05.10303180613040.29730-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Mar 2003, Neale Banks wrote:

> On Mon, 17 Mar 2003, Tomas Szepe wrote:
> 
> > > [alan@lxorguk.ukuu.org.uk]
> > > 
> > > If you build your own kernels apply the patch, if you use vendor kernels
> > > then you can expect vendor kernel updates to appear or have already
> > > appeared
> > 
> > You have avoided the question(s).  8)
> 
> I think Alan's trying to teach us how to fish ;-)
> 
> That said, IMVHO something like this does constitute an argument for
> 2.4.20-p1 (due to the amount of change that's already racked up for
> 2.2.21).

Hi all,
There is a clean patch for 2.4.20 (taken from Alans original patch) at
http://www.hardrock.org/kernel/2.4.20/linux-2.4.20-ptrace.patch

I am currently using it on 3 production systems at work and
it seems stable. You will notice processes which are not dumpable with
this patch, as the output from ps ax will contain the process name in []
square brackets.

Regards
James Bourne

> Regards,
> Neale.

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************


"There are only 10 types of people in this world: those who
understand binary and those who don't."

