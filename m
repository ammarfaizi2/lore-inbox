Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754799AbWKIJ3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799AbWKIJ3J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 04:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754805AbWKIJ3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 04:29:09 -0500
Received: from outmx023.isp.belgacom.be ([195.238.4.204]:33209 "EHLO
	outmx023.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1754799AbWKIJ3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 04:29:07 -0500
Message-ID: <4552F4E1.2090104@trollprod.org>
Date: Thu, 09 Nov 2006 10:29:05 +0100
From: Olivier Nicolas <olivn@trollprod.org>
User-Agent: Thunderbird 2.0b1pre (X11/20061106)
MIME-Version: 1.0
To: Yinghai Lu <yinghai.lu@amd.com>
CC: Adrian Bunk <bunk@stusta.de>, Stephen Hemminger <shemminger@osdl.org>,
       Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com,
       linux-acpi@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19-rc5 x86_64 irq 22: nobody cared
References: <4551D12D.4010304@trollprod.org> <20061109064956.GG4729@stusta.de> <86802c440611082355q67c69da2v316062bbe0170a9@mail.gmail.com>
In-Reply-To: <86802c440611082355q67c69da2v316062bbe0170a9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yinghai Lu wrote:
> olivier,
> 
> lspci -vvxxx please.
> 
> it seems usb and audio share the interrtupts by ioapic.
> 
> YH

lspci -vvxxx is available at http://olivn.trollprod.org/lspci.gz

2.6.19-rc5 can be booted properly on my system if "notsc" parameter is used.

Could it be related to http://lkml.org/lkml/2006/10/27/141 as I'm usage 
a dual core AMD64 ?



Olivier


