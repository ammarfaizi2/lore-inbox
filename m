Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUFPUBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUFPUBI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 16:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbUFPUBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 16:01:08 -0400
Received: from web51807.mail.yahoo.com ([206.190.38.238]:40295 "HELO
	web51807.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264704AbUFPUBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 16:01:02 -0400
Message-ID: <20040616200102.93550.qmail@web51807.mail.yahoo.com>
Date: Wed, 16 Jun 2004 13:01:02 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: Programtically tell diff between HT and real
To: David van Hoose <david.vanhoose@comcast.net>, Robert Love <rml@ximian.com>
Cc: Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <40D0A63F.9000809@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, if I understand correctly, there is no way to know
definitively if a cpu is HT or not?

Thanks!
Phy

--- David van Hoose <david.vanhoose@comcast.net>
wrote:
> 
> 
> Robert Love wrote:
> > On Wed, 2004-06-16 at 13:56 -0400, Robert Love
> wrote:
> > 
> > 
> >>Yah.  Look at /proc/cpuinfo.
> >>
> >>Virtual processors have different 'processor'
> values but the same
> >>'physical id', while physical processors obviously
> have different values
> >>for both.
> > 
> > 
> > Oh, and if you just want to see if a processor
> supports HT - the 'ht'
> > flag is set in 'flags' in /proc/cpuinfo.
> 
> Not always true. I have a non-HT Pentium4, but I
> still have ht in my 
> flags. The same goes for a couple of dual Xeon's I
> work on at school. 
> Aparently Intel disabled the HT on a lot of Pentium
> 4 and Xeon chips, 
> but left the HT flag behind. My system even has the
> additional IO-APICs 
> too. Hence why everytime I boot a UP kernel, I get
> an 'unexpected 
> IO-APIC' message.
> 
> Cheers,
> David
> 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
