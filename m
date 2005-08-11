Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVHKRSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVHKRSb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVHKRSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:18:30 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:17875 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751133AbVHKRS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:18:29 -0400
Subject: Re: Need help in understanding x86 syscall
From: Steven Rostedt <rostedt@goodmis.org>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>, 7eggert@gmx.de,
       Ukil a <ukil_a@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <2cd57c9005081109597b18cc54@mail.gmail.com>
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz>
	 <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com>
	 <1123770661.17269.59.camel@localhost.localdomain>
	 <2cd57c90050811081374d7c4ef@mail.gmail.com>
	 <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com>
	 <1123775508.17269.64.camel@localhost.localdomain>
	 <1123777184.17269.67.camel@localhost.localdomain>
	 <2cd57c90050811093112a57982@mail.gmail.com>
	 <2cd57c9005081109597b18cc54@mail.gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 11 Aug 2005 13:18:01 -0400
Message-Id: <1123780681.17269.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-12 at 00:59 +0800, Coywolf Qi Hunt wrote:
> On 8/12/05, Coywolf Qi Hunt <coywolf@gmail.com> wrote:
> > On 8/12/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge

> > The cpu does have sep. Is it vanilla kernel?
> > 

It's vanilla 2.6.12-rc3 + Ingo's RT V0.7.46-02-rs-0.4 + some of my own
customizations.  But I never touched the sysentry stuff and with a few
printks I see it is being initialized.

> 
> Also glibc support.
> 

I'm using Debian unstable with a recent (last week) update.

-- Steve


