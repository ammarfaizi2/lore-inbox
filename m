Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751643AbWKBDEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbWKBDEO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 22:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbWKBDEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 22:04:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22920 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751638AbWKBDEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 22:04:13 -0500
Date: Wed, 1 Nov 2006 22:03:53 -0500
From: Dave Jones <davej@redhat.com>
To: Stephen Clark <Stephen.Clark@seclark.us>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: fc6 kernel 2.6.18-1.2798 breaks acpi on HP laptop n5430
Message-ID: <20061102030353.GA2797@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Stephen Clark <Stephen.Clark@seclark.us>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <4548DDF4.2030903@seclark.us> <20061101201218.GA4899@martell.zuzino.mipt.ru> <45490EFE.1060608@seclark.us> <20061101235546.GB10577@redhat.com> <4549450F.3080207@seclark.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4549450F.3080207@seclark.us>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 08:08:31PM -0500, Stephen Clark wrote:

 > booting without lapic allowed it to boot but now I get
 > ...
 > Local APIC disabled by BIOS -- you can enable it with "lapic"
 > ...
 > Local APIC not detected. Using dummy APIC emulation.
 >   which means more processor overhead - right?
 > 
 > also cpuspeed doesn't work anymore - I don't have a cpufreq dir

The Duron had powernow ?

Hmm, anyway, there was a FC6 installer bug where it installed
the 586 kernel instead of the 686 one.
See http://fedoraproject.org/wiki/Bugs/FC6Common#head-e0676100ebd965b92fbaa7111097983a3822f143
for details and a workaround.

	Dave

-- 
http://www.codemonkey.org.uk
