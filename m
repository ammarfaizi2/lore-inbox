Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266473AbSLDMyM>; Wed, 4 Dec 2002 07:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266478AbSLDMyM>; Wed, 4 Dec 2002 07:54:12 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:44480 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266473AbSLDMyL>;
	Wed, 4 Dec 2002 07:54:11 -0500
Date: Wed, 4 Dec 2002 12:58:52 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] ACPI updates
Message-ID: <20021204125852.GE647@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Arjan van de Ven <arjanv@redhat.com>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A56D@orsmsx119.jf.intel.com> <20021203184705.A23371@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021203184705.A23371@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 06:47:05PM -0500, Arjan van de Ven wrote:
 > On Tue, Dec 03, 2002 at 03:29:56PM -0800, Grover, Andrew wrote:
 > > Well maybe that's what we should do - use the UnitedLinux ACPI patch (which
 > 
 > No. What UL did was to put back the code you remove. YOU can do that
 > better I'm sure, since you actively remove it in your patch;
 > just not doing that is obviously simpler...

There's also a few other things in the UL patch Andi did iirc,
things like 'dont use ACPI if the BIOS date is <2000', which seems
to be a good universal crap-acpi-bios detector. (You can still override
this with a bootarg iirc)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
