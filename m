Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266259AbUAVOJO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 09:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266264AbUAVOJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 09:09:14 -0500
Received: from dsl-213-023-011-163.arcor-ip.net ([213.23.11.163]:8905 "EHLO
	fusebox.fsfeurope.org") by vger.kernel.org with ESMTP
	id S266259AbUAVOJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 09:09:12 -0500
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Martin Loschwitz <madkiss@madkiss.org>, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: PROBLEM: ACPI freezes 2.6.1 on boot
References: <7F740D512C7C1046AB53446D3720017361885C@scsmsx402.sc.intel.com>
	<m3u12pgfpr.fsf@reason.gnu-hamburg>
	<m3ptddgckg.fsf@reason.gnu-hamburg>
	<20040122120854.GB3534@hell.org.pl>
From: "Georg C. F. Greve" <greve@gnu.org>
Organisation: Free Software Foundation Europe - GNU Project
X-PGP-Fingerprint: 2D68 D553 70E5 CCF9 75F4 9CC9 6EF8 AFC2 8657 4ACA
X-PGP-Affinity: will accept encrypted messages for GNU Privacy Guard
X-Home-Page: http://gnuhh.org
X-Accept-Language: en, de
Date: Thu, 22 Jan 2004 15:08:56 +0100
In-Reply-To: <20040122120854.GB3534@hell.org.pl> (Karol Kozimor's message of
 "Thu, 22 Jan 2004 13:08:54 +0100")
Message-ID: <m3browulc7.fsf@reason.gnu-hamburg>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 || On Thu, 22 Jan 2004 13:08:54 +0100
 || Karol Kozimor <sziwan@hell.org.pl> wrote: 

 >> So the problem we've been seeing seems to be related to the
 >> interaction between local APIC support and ACPI.

 kk> We've definitely had those problems before (with ASUS L3800C),
 kk> there's even a patch fixing this issue (attached below) you might
 kk> try.  I guess that's another of those lost and forgotten bugzilla
 kk> bugs :)

Thanks a lot -- this patch fixed the problem for me.

The kernel now found the APIC and initialized ACPI (including
switching to level trigger) with no problems.

Could we please make sure this doesn't get lost again and makes it
into the kernel?

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve@gnu.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)
