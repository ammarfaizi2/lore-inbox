Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267200AbTAFVye>; Mon, 6 Jan 2003 16:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267225AbTAFVye>; Mon, 6 Jan 2003 16:54:34 -0500
Received: from palrel13.hp.com ([156.153.255.238]:52618 "HELO palrel13.hp.com")
	by vger.kernel.org with SMTP id <S267200AbTAFVyd>;
	Mon, 6 Jan 2003 16:54:33 -0500
Date: Mon, 6 Jan 2003 14:01:35 -0800
To: Andrew Walrond <andrew@walrond.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
Message-ID: <20030106220135.GF26790@cup.hp.com>
References: <Pine.LNX.4.44.0301052009050.3087-100000@home.transmeta.com> <1041848998.666.4.camel@zion.wanadoo.fr> <3E19694D.8030306@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E19694D.8030306@walrond.org>
User-Agent: Mutt/1.4i
From: grundler@cup.hp.com (Grant Grundler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 11:32:29AM +0000, Andrew Walrond wrote:
> 2.5.53 and 2.5.54 do not seem to find everything on the pci bus on this 
> asus pr-dls dual p4 xeon m/b
...
> But with 2.5.53/2.5.54 bus 14 and bus 18 are missing:
...
> ACPI is enabled in both cases (Won't boot with pci=noacpi)

Could this be an ACPI resource bug?
I thought ACPI reported the PCI bus controllers and it's possible
the 2.5.x code is just not finding the right resources.

In any case, I don't think this is related to the original problem.

grant
