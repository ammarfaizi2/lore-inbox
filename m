Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUDWBap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUDWBap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 21:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264263AbUDWBap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 21:30:45 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:13972 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S264261AbUDWBan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 21:30:43 -0400
Date: Thu, 22 Apr 2004 18:30:39 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Message-ID: <20040423013039.GA4945@tesore.local>
Mail-Followup-To: Jesse Allen <the3dfxdude@hotmail.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> Have you been able to hang the AN35N under any conditions?
> Old BIOS, non-vanilla kernel?

Yes, and I described that it will hang under the pre-Dec 5th BIOS in another 
mail.

I still have images of the buggy BIOS, and the fixed one on my hard drive.
They are also available at ftp://ftp.shuttle.com/BIOS/an35_n/ as
an35s00j.bin (Oct 2003)
an35s00l.bin (Dec 5th 2003)

XT-PIC timer bug still remains in both versions.

> I'm not familiar with the "one removed by Linus in a testing version",
> perhaps you could point me to that?

I had forgot the name, and hadn't looked it up.  But it is the 8259 timer ack 
workaround.  You can see the removal here:
http://linux.bkbits.net:8080/linux-2.5/cset@1.1608.99.1


Jesse

