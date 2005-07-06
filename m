Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbVGGAXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbVGGAXG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVGFUAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:00:43 -0400
Received: from main.gmane.org ([80.91.229.2]:46518 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262223AbVGFQum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:50:42 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pedro Ramalhais <ramalhais@serrado.net>
Subject: Re: speedstep-centrino on dothan
Date: Wed, 06 Jul 2005 17:30:14 +0100
Message-ID: <42CC0716.9030108@serrado.net>
References: <20050706112202.33d63d4d@horst.morte.male>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: gandalf.uninova.pt
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
In-Reply-To: <20050706112202.33d63d4d@horst.morte.male>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

st3@riseup.net wrote:
> Currently, the speedstep-centrino support has built-in frequency/voltage
> pairs only for Banias CPUs. For Dothan CPUs, these tables are read from
> BIOS ACPI.
> 
> But ACPI encoding may not be available or not reliable, so why shouldn't we
> provide built-in tables for Dothan CPUs, too? Intel has released this
> datasheet:
> 
> http://www.intel.com/design/mobile/datashts/302189.htm
> 
> with frequency/voltage pairs for every version of Dothan CPUs.
> 
> Moreover, I checked on Pentium M 725 and Pentium M 715 that the lowest
> frequency at which the CPU can be set safely is not the 600MHz given in
> datasheets, but 400MHz instead, with VID#A, VID#B, VID#C and VID#D (see
> datasheet for more details) set to 0.908V.
> 
> I can provide a patch, let me know.
> 
> 
> --
> ciao
> st3
> 

I looked into it 2 weeks ago, and i couldn't find a complete voltage
table for the Dothan C1 stepping (which my laptop has). I only found a
table with (IIRC) the max and min voltages for the max and min
frequencies. I also didn't understand the meaning of the different
VID#{A,B,C,D,E} values. Are these voltages related to the quality of the
power supply, or the quality of the processor? How do we know which one
to choose?

Regards,
--
Pedro Ramalhais

