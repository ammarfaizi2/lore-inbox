Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266640AbUGQGuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266640AbUGQGuO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 02:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbUGQGuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 02:50:14 -0400
Received: from fmr01.intel.com ([192.55.52.18]:56719 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S266640AbUGQGuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 02:50:05 -0400
Subject: Re: ACPI hang on Compaq 2199US laptop with kernel 2.6.7
From: Len Brown <len.brown@intel.com>
To: "Robert W. Fuller" <kombi@sbcglobal.net>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <566B962EB122634D86E6EE29E83DD808182C0577@hdsmsx403.hd.intel.com>
References: <566B962EB122634D86E6EE29E83DD808182C0577@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1090046999.2787.18.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 Jul 2004 02:49:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

no, not an RTFM, but a pretty common failure,
especially on Compaq laptops.

Cause unknown, though we've got some clues:

http://bugzilla.kernel.org/show_bug.cgi?id=1269

-Len

On Fri, 2004-07-16 at 15:17, Robert W. Fuller wrote:
> That solved the problem!  The laptop boots with ACPI as long as I 
> specify the "nolapic" option.
> 
> Is this an RTFM?  If so, where is the manual?
> 
> Li, Shaohua wrote:
> > Please try 'nolapic' boot option. -Shaohua
> > 
> > 
> >>-----Original Message-----
> >>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> >>owner@vger.kernel.org] On Behalf Of Robert W. Fuller
> >>Sent: Wednesday, July 14, 2004 11:58 PM
> >>To: linux-kernel@vger.kernel.org
> >>Subject: Re: ACPI hang on Compaq 2199US laptop with kernel 2.6.7
> >>
> >>Hmm.  No reply.  Am I not asking for help in the right place?
> >>
> >>Robert W. Fuller wrote:
> >>
> >>>If I have ACPI configured for the 2.6.7 kernel, boot hangs after
> the
> >>>message "ACPI: IRQ9 SCI: Level Trigger."  If I configure the 2.6.7
> >>>kernel without ACPI, everything is fine.
> >>>
> >>>I would like to have ACPI because my laptop does not have APM.  The
> >>>laptop model is a Compaq Presario 2199US.
> >>>-
> >>>To unsubscribe from this list: send the line "unsubscribe
> > 
> > linux-kernel"
> > 
> >>in
> >>
> >>>the body of a message to majordomo@vger.kernel.org
> >>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>Please read the FAQ at  http://www.tux.org/lkml/
> >>>
> >>
> >>-
> >>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel"
> > 
> > in
> > 
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > 
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

