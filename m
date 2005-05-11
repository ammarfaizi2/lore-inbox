Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVEKIKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVEKIKN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 04:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVEKIKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 04:10:13 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:40694 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261919AbVEKIKH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 04:10:07 -0400
Date: Wed, 11 May 2005 13:39:59 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Alexander Nyberg <alexn@telia.com>
Cc: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       fastboot@lists.osdl.org, rddunlap@osdl.org, Ralf.Hildebrandt@charite.de,
       petkov@uni-muenster.de, Morton Andrew Morton <akpm@osdl.org>,
       coywolf@gmail.com
Subject: Re: [Fastboot] Fw: Re: kexec?
Message-ID: <20050511080959.GB3799@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20050510193225.53192aad.akpm@osdl.org> <20050511030201.GA3799@in.ibm.com> <1115795427.917.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115795427.917.10.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > maxcpus=1 is the culprit. Even through bios/grub kernel does not boot with 
> > option maxcpus=1. It is a known issue with got notieced 2.6.12-rc2-mm1 onwards. 
> > So build second kernel as uniprocessor kernel and don't specify maxcpus=1 and 
> > test it out. It should work.
> > 
> 
> Vivek,
> 
> kexec-tools-1.101 does not contain your last patch series (that includes
> --crashdump which is lacking from the above cmdline). Currently you need
> to patch up 1.101 with the stuff from 
> [RFC/PATCH 5/17][kexec-tools-1.101] Add command line option
> "--crash-dump" etc.
> 
> It would be good having a 1.2 or something with the patches included on
> the site...

We have uploaded the kdump related user space patches which can be 
accessed at following link.

http://lse.sourceforge.net/kdump/patches/

A single consolidated patch can be applied on top of kexec-tools-1.101.tar.gz
to get kdump working.

Thanks
Vivek


