Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbTIKLGl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 07:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbTIKLGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 07:06:41 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:27413 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261215AbTIKLGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 07:06:38 -0400
Date: Thu, 11 Sep 2003 12:04:35 +0100
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030911110435.GA1225@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@fs.tum.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200309071647.h87Glp4t014359@harpo.it.uu.se> <20030907174341.GA21260@mail.jlokier.co.uk> <1062958188.16972.49.camel@dhcp23.swansea.linux.org.uk> <20030911062816.GX27368@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911062816.GX27368@fs.tum.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 08:28:16AM +0200, Adrian Bunk wrote:

 > - Does the Cyrix III support 686 instructions?

Depends on your definition of 686. If you follow the Intel
definition (where CMOV is optional), yes. If you follow the gcc
definition (where CMOV is assumed), no.
Except for the latest Nehemiah cores (which now have CMOV).

 > - Do -march=winchip{2,-c6} and -march=c3{,-2} add anything not in
 >   -march=i686 (except optimizations of otherwise compatible code)?

Not afaik.

 > - Which CPUs exactly need X86_ALIGNMENT_16?

Unsure. This could use testing on a few systems.

 > - X86_GOOD_APIC: Are there really that many processors with a bad APIC?

Mikael ?

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
