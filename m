Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265716AbUFWGAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265716AbUFWGAi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 02:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUFWGAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 02:00:35 -0400
Received: from [63.193.79.19] ([63.193.79.19]:6016 "HELO mwg.inxservices.lan")
	by vger.kernel.org with SMTP id S265716AbUFWGAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 02:00:34 -0400
Date: Tue, 22 Jun 2004 23:00:13 -0700
From: George Garvey <tmwg-linuxknl@inxservices.com>
To: Len Brown <len.brown@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7 NULL pointer dereference during boot
Message-ID: <20040623060013.GA3568@inxservices.com>
Mail-Followup-To: Len Brown <len.brown@intel.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <A6974D8E5F98D511BB910002A50A6647615FE6B4@hdsmsx403.hd.intel.com> <1087651896.4486.220.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087651896.4486.220.camel@dhcppc4>
User-Agent: Mutt/1.4.1i
Organization: inX Services, Los Angeles, CA, USA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 09:31:36AM -0400, Len Brown wrote:
> On Fri, 2004-06-18 at 20:29, George Garvey wrote:
> 
> > ACPI: Subsystem revision 20040326
> > Unable to handle kernel NULL pointer dereference
> 
> Probably it is this failure:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=125841
> 
> known workarounds:
> 
> CONFIG_SCHED_SMT=n
> "acpi=off"
> "acpi=ht"
> "maxcpus=1"

   Thanks. That did indeed allow a boot.
