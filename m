Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWHOVGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWHOVGN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 17:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWHOVGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 17:06:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39835 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750712AbWHOVGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 17:06:12 -0400
Date: Tue, 15 Aug 2006 14:02:49 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Bill Nottingham <notting@redhat.com>
Cc: Mitch Williams <mitch.a.williams@intel.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: bonding: cannot remove certain named devices
Message-ID: <20060815140249.15472a82@dxpl.pdx.osdl.net>
In-Reply-To: <20060815204555.GB4434@nostromo.devel.redhat.com>
References: <20060815194856.GA3869@nostromo.devel.redhat.com>
	<Pine.CYG.4.58.0608151331220.3272@mawilli1-desk2.amr.corp.intel.com>
	<20060815204555.GB4434@nostromo.devel.redhat.com>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 16:45:55 -0400
Bill Nottingham <notting@redhat.com> wrote:

> Mitch Williams (mitch.a.williams@intel.com) said: 
> > Are spaces allowed in interface names anyway?  I can't believe that
> > bonding is the only area affected by this.
> 
> They're certainly allowed, and the sysfs directory structure, files,
> etc. handle it ok. Userspace tends to break in a variety of ways.
> 
> I believe the only invalid character in an interface name is '/'.
> 

The names "." and ".." are also verboten.
Names with : in them are for IP aliases.
