Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262857AbTCRXqi>; Tue, 18 Mar 2003 18:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262859AbTCRXqh>; Tue, 18 Mar 2003 18:46:37 -0500
Received: from air-2.osdl.org ([65.172.181.6]:7814 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262857AbTCRXqh>;
	Tue, 18 Mar 2003 18:46:37 -0500
Subject: Re: seqlock/unlock(&xtime_lock) problems cause keyboard, time skew
	problems
From: Stephen Hemminger <shemminger@osdl.org>
To: Jerry Cooperstein <coop@axian.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030318205907.GB4081@p3.attbi.com>
References: <20030318190557.GA14447@p3.attbi.com>
	 <1048019543.6294.3.camel@dell_ss3.pdx.osdl.net>
	 <20030318205907.GB4081@p3.attbi.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1048031851.6296.75.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 18 Mar 2003 15:57:32 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-18 at 12:59, Jerry Cooperstein wrote:
> On Tue, Mar 18, 2003 at 12:32:24PM -0800, Stephen Hemminger wrote:
> > On Tue, 2003-03-18 at 11:05, Jerry Cooperstein wrote:
> > > Since 2.5.60 my thinkpad keyboard repeat rate has been erratic when
> ....
> 
> > 
> > Does this notebook vary the clock rate? If so then using TSC for 
> > time of day clock is probably a problem.  Try booting with notsc.
> 
> Yes the notebook varies the clock rate -- its about 150MHZ with
> batter power, 500 MHZ on AC.

Part of the problem may be that the clock rate can change but the
cpu frequency code can't support the Intel SpeedStep.  

Maybe, someone with more direct experience with laptop's can help.

