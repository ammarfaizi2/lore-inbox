Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261778AbSJQEWi>; Thu, 17 Oct 2002 00:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261776AbSJQEWi>; Thu, 17 Oct 2002 00:22:38 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:20244 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261775AbSJQEWg>; Thu, 17 Oct 2002 00:22:36 -0400
Date: Thu, 17 Oct 2002 00:28:51 -0400
From: Doug Ledford <dledford@redhat.com>
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
       linux-scsi@vger.kernel.org
Subject: Re: 2.5.43 IO-APIC bug and spinlock deadlock
Message-ID: <20021017042851.GQ8159@redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, linux-scsi@vger.kernel.org
References: <20021017033302.GP8159@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017033302.GP8159@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 11:33:02PM -0400, Doug Ledford wrote:
> IO-APIC bug: regular kernel, UP, no IO-APIC or APIC on UP enabled, compile
> fails (does *everyone* run SMP or at least UP + APIC now?)

OK, this is real.

> spinlock deadlock: run an smp kernel on a up machine.  On mine here all I 
> have to do is try to boot to multiuser mode, it won't make it through the 

This turned out to be a red herring.  Up on Up failed for me to.  Did 
finally track down to the area of the problem.  That will be under 
separate email with different subject so it will get the right person's 
attention.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
