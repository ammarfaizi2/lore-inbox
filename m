Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423623AbWKAFLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423623AbWKAFLv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423642AbWKAFLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:11:50 -0500
Received: from moci.net4u.de ([217.7.64.195]:63655 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S1423623AbWKAFLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:11:49 -0500
From: Ernst Herzberg <earny@net4u.de>
To: Len Brown <lenb@kernel.org>
Subject: Re: 2.6.19-rc <-> ThinkPads
Date: Wed, 1 Nov 2006 06:11:27 +0100
User-Agent: KMail/1.9.1
Cc: Adrian Bunk <bunk@stusta.de>, Hugh Dickins <hugh@veritas.com>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>, Pavel Machek <pavel@suse.cz>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       Martin Lorenz <martin@lorenz.eu.org>
References: <20061029231358.GI27968@stusta.de> <20061101030126.GE27968@stusta.de> <200610312215.44454.len.brown@intel.com>
In-Reply-To: <200610312215.44454.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611010611.30445.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 November 2006 04:15, Len Brown wrote:
> The BIOS disables the LAPIC for a reason.
> A couple of years ago Linux made the mistake of enabling the LAPIC
> that the BIOS disabled, and all hell broke loose.
> We fixed that bug about a year ago, but left "lapic"
> to force it on for those where forcing it to be enabled actually
> works (eg. some folks want the NMI profiling on their IOAPIC-less  laptop)
>
> But if you force the lapic to be enabled, you are running the system
> in a mode not supported by the manufacturer and you are on your own.
>
> I don't see an indication that this is a bug.
> If it used to work and it is important to you,
>  then run the old software where it used to work --
> because chances are good that it worked by accident.

Maybe. But why does it boot with AC connected and lapic enabled, bot not if AC 
is disconnected and lapic enabled? If have no problem to run this laptop 
without lapic, i don't relly need it. But i wondering that this happens only 
if the machine runs (by accident:) on battery.

still bisecting, will report the result.

<earny>
