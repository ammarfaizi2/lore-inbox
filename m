Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbUCTKRp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 05:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263318AbUCTKRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 05:17:45 -0500
Received: from gizmo01bw.bigpond.com ([144.140.70.11]:61863 "HELO
	gizmo01bw.bigpond.com") by vger.kernel.org with SMTP
	id S263311AbUCTKRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 05:17:43 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Len Brown <len.brown@intel.com>
Subject: Re: idle Athlon with IOAPIC is 10C warmer since 2.6.3-bk1
Date: Sat, 20 Mar 2004 20:19:44 +1000
User-Agent: KMail/1.5.1
Cc: Thomas Schlichter <thomas.schlichter@web.de>, linux-kernel@vger.kernel.org
References: <200403181019.02636.ross@datscreative.com.au> <1079738422.7279.308.camel@dhcppc4> <405C0EF1.1060104@gmx.de>
In-Reply-To: <405C0EF1.1060104@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403202019.44612.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 March 2004 19:29, Prakash K. Cheemplavam wrote:
> Len Brown wrote:
> > On Fri, 2004-03-19 at 14:22, Prakash K. Cheemplavam wrote:
> > 
> > 
> >>Hmm, I just did a cat /proc/acpi/processor/CPU0/power:
> >>active state:            C1
> >>default state:           C1
> >>bus master activity:     00000000
> >>states:
> >>    *C1:                  promotion[--] demotion[--] latency[000] 
> >>usage[00000000]
> >>     C2:                  <not supported>
> >>     C3:                  <not supported>
> >>
> >>I am currently NOT using APIC mode (nforce2, as well) and using vanilla 
> >>2.6.4. It seems C1 halt state isn't used, which exlains why I am having 
> [snip]
> > 
> > 
> > Actually I think it is that we don't _count_ C1 usage.
> 
> Hmm, OK, then I am really puzzled what specifically about mm sources 
> make my idle temps hotter, as I still couldn't properly resolve it what 
> is causing it. I thought ACPI, but no, using APM only does the same (apm 
> only with vanilla is low temp though.)

Hi Prakash,

Have you seen this thread, it may be relevant?
Re: [2.6.4-rc2] bogus semicolon behind if()
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-03/4170.html

I have not looked to see which kern sources besides 2.6.4-rc2 may have it.

Regards
Ross.


> 
> Prakash
> 
> 
> 

