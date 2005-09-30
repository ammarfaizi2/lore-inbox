Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbVI3N0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbVI3N0K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 09:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbVI3N0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 09:26:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15583 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030296AbVI3N0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 09:26:08 -0400
Date: Fri, 30 Sep 2005 09:25:44 -0400
From: Dave Jones <davej@redhat.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Wes Felter <wesley@felter.org>, linux-kernel@vger.kernel.org
Subject: Re: em64t speedstep technology not supported in kernel yet?
Message-ID: <20050930132544.GC15658@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	Wes Felter <wesley@felter.org>, linux-kernel@vger.kernel.org
References: <88056F38E9E48644A0F562A38C64FB6005DECA9D@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6005DECA9D@scsmsx403.amr.corp.intel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 06:20:15AM -0700, Pallipadi, Venkatesh wrote:

 > Actually, speedstep-centrino works in two modes. One OP() 
 > table based mode and the other ACPI table based mode. So, 
 > BIOS ACPI tables do matter for the second mode and things 
 > work without a static OP table.

True. Ack, I've spent too much time playing with that driver
and broken BIOS's lately, that I'd forgotten about this. :)

 > In this particular case though, for Xeon with Enhanced Speedstep, 
 > acpi-cpufreq should be the driver of choice as there is a need 
 > for coordination of HT siblings, which happen in BIOS at the 
 > moment with most BIOSes. That is the reason, I want to make 
 > sure BIOS supports Enhanced Speedstep in this case.

Ok, that makes sense.

		Dave

