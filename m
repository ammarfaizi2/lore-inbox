Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbUKJTSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbUKJTSU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 14:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbUKJTSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 14:18:20 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:46479 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262096AbUKJTSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 14:18:13 -0500
Subject: Re: CELF interest in suspend-to-flash
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Tim Bird <tim.bird@am.sony.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <20041110154136.GA12444@logos.cnet>
References: <419256F8.3010305@am.sony.com>
	 <1100109991.12290.41.camel@desktop.cunninghams>
	 <20041110154136.GA12444@logos.cnet>
Content-Type: text/plain
Message-Id: <1100114233.3876.4.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 11 Nov 2004 06:17:14 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-11 at 02:41, Marcelo Tosatti wrote:
> On Thu, Nov 11, 2004 at 05:06:31AM +1100, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Thu, 2004-11-11 at 04:59, Tim Bird wrote:
> > > Hi all,
> > > 
> > > Lately, the CE Linux Forum power management working group is showing some
> > > interest in suspend-to-flash.  Is there any current work in this area?
> > > 
> > > Who should we talk to if we want to get involved with this (or lead
> > > an effort if there isn't one)?
> > 
> > Can flash be treated as a swap device at the moment? If so, it might
> > simply be a matter of specifying the same parameter used in swapon for
> > the resume2= boot parameter.
> 
> Sure, you only need to have the flash as a block device (ie driven 
> by the IDE code).

Cool. In that case, it should work fine with either swsusp (the mainline
implementation) or suspend2.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

