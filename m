Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030532AbWJKDCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030532AbWJKDCc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 23:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030554AbWJKDCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 23:02:31 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:58541 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1030532AbWJKDCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 23:02:30 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=kujPkvAstMu1j+Rxu7EOfxaxOGiCGHcqWDPbvu9R/iB09UWmxQJZg87AKN3ICtZXrwYBuj2QhfHbG55MyQQLr1/169Pr62DUlM/VPpt272n2/2skBtVo4jXTZaU7M/Zz;
X-IronPort-AV: i="4.09,292,1157346000"; 
   d="scan'208"; a="95184957:sNHT15724566"
Date: Tue, 10 Oct 2006 22:02:32 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Yu Luming <luming.yu@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net,
       ismail@pardus.org.tr
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Message-ID: <20061011030232.GA27693@lists.us.dell.com>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061005103657.GA4474@ucw.cz> <20061006211751.GA31887@lists.us.dell.com> <200610102232.46627.luming.yu@gmail.com> <20061010212615.GB31972@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010212615.GB31972@srcf.ucam.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 10:26:15PM +0100, Matthew Garrett wrote:
> On Tue, Oct 10, 2006 at 10:32:46PM +0800, Yu Luming wrote:
> 
> > >From my understanding, a cute userspace App shouldn't have this kind
> > of logic:
> 
> (snip switching on hardware type)
> 
> > It should be:
> > 	just write/read  file in  /sys/class/backlight ,....
> 
> Yup, but to do that on Dell hardware is basically impossible. It'd be 
> nice if they implemented the ACPI video extension properly for future 
> hardware.

Yes, our BIOS teams are looking to do exactly that.  I wouldn't expect
such a change to be propogated back to earlier released systems though.

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
