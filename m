Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266838AbUIROdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266838AbUIROdN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 10:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269518AbUIROdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 10:33:13 -0400
Received: from web53504.mail.yahoo.com ([206.190.37.65]:40821 "HELO
	web53504.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266838AbUIROdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 10:33:06 -0400
Message-ID: <20040918143305.5840.qmail@web53504.mail.yahoo.com>
Date: Sat, 18 Sep 2004 07:33:05 -0700 (PDT)
From: Lawrence Wong <lawrencewong72@yahoo.com>
Subject: Re: Kernel 2.8.6.1 & VLAN & E100
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41478AFD.2080700@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

I tried rc2-bk1 & rc2-bk3. rc2-bk1 solved the problem
but rc2-bk3 crashed on startup when trying to bring up
the loopback interface. The error started off with
something about fib_.... but I was not able to capture
it in the syslog.

I guess I'll stick to rc2-bk1 for now.

Thanks for the great help!

--- Ben Greear <greearb@candelatech.com> wrote:

> Lawrence Wong wrote:
> > Hi everyone,
> > 
> > I am currently using Fedora Core 2 on a P3 w/512MB
> > RAM, 2 x 18.2GB SCSI in RAID1 via an IBM
> ServeRAID-4M.
> > Network card is an Intel 100 S controller.
> > 
> > All except the kernel is stock FC2. The kernel is
> > 2.6.8.1 and compiled from the tarball found on
> > ftp.kernel.org .
> > 
> > Everything works fine until I tried to enable VLAN
> and
> > use VLAN subinterfaces. The VLAN subinterface
> comes up
> > fine but the moment I send traffic in/out of the
> > interface (i.e. ping), a huge and neverending
> chunk of
> > "bad scheduling while atomic" errors pop up
> > immediately and does not go away until I press
> > CTRL+ALT+DEL.
> > 
> > An extract of the error can be found below. But
> when I
> > run the system in normal non-VLAN mode, the
> problem
> > does not occur. So I am inclined to believe it
> either
> > has something to do with the VLAN driver or VLAN
> > driver + INTEL 10/100 driver.
> > 
> > Has anyone encountered before or know of any
> > solutions?
> 
> A patch is in the latest bk tree, at least.
> 
> Ben
> 
> -- 
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
> 
> 



		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
