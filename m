Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVGFUPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVGFUPX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVGFUNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:13:52 -0400
Received: from main.gmane.org ([80.91.229.2]:56749 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262215AbVGFT5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 15:57:05 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: speedstep-centrino on dothan
Date: Wed, 06 Jul 2005 15:58:53 -0400
Message-ID: <42CC37FD.5040708@tmr.com>
References: <20050706112202.33d63d4d@horst.morte.male>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: prgy-npn1.prodigy.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
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

Slower is better, and not depending on ACPI for anything which can be 
gotten elsewhere is a good thing. Sounds like a good idea to me.

