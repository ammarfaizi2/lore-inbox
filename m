Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUCRDCT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 22:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbUCRDCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 22:02:18 -0500
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:10935 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S262370AbUCRDCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 22:02:17 -0500
From: Richard Browning <richard@redline.org.uk>
Organization: Redline Software Engineering
To: Len Brown <len.brown@intel.com>
Subject: Re: SMP + Hyperthreading / Asus PCDL Deluxe / Kernel 2.4.x 2.6.x / Crash/Freeze
Date: Thu, 18 Mar 2004 03:01:07 +0000
User-Agent: KMail/1.6.1
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F4B99@hdsmsx402.hd.intel.com> <1079072878.3885.33.camel@dhcppc4> <1079075236.3885.52.camel@dhcppc4>
In-Reply-To: <1079075236.3885.52.camel@dhcppc4>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403180301.07385.richard@redline.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 March 2004 07:07, Len Brown wrote:
> Hmm, read that note too fast...
> Since the failure did not follow the package to the BSP socket
> (CPU0/CPU1), but instead stayed with the AP (CPU2/CPU3) socket, that
> suggests an issue with the MB rather than the processor itself.

Right then. I've just 'borrowed' the same motherboard (Asus PC-DL Deluxe) and 
CPUs from the local friendly computer place. I simply connected the hard 
drive to their combo and booted. SAME RESULT.

To confirm these (SEVERE) issues, I installed (deep breath, apologies, etc,) 
Windows XP Pro. Regrettably, the Micro$oft beast worked perfectly. Four 
processors in task manager, no hangs after several hours of 'doing stuff'.

I don't know what's going on with Linux and this motherboard. Is it the 
strangeness of Asus putting a Canterwood and Intel ICH5 chipset together to 
get the 533 FSB out of the Xeon?

The symptoms only show up if I'm doing 'dev'. In other words, I can boot into 
KDE, play music, watch DVDs and even play Enemy Territory - all with HT 
enabled. However AS SOON as I begin the configure/make/install cycle the 
system will hang. It's almost like an interrupt is gumming up the works 
somehow, but I lack the expertise to pinpoint it. For the record, I'm running 
a Radeon9800Pro graphics card.

I dunno why there haven't been more issues like this. Then again, most of the 
folk I hear on the Asus forums are using these mobos with Windoze.

What can I do to help you chaps get to the bottom of this? (Interestingly I 
note that turning off ACPI - not APIC - with HT enabled causes the kernel to 
not realise that HT is in fact enabled. I though the kernel used CPUIDs to 
work out whether HT was enabled?)

R
