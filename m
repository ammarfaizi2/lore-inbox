Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284709AbRLEVKQ>; Wed, 5 Dec 2001 16:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284730AbRLEVKK>; Wed, 5 Dec 2001 16:10:10 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:52378 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S284709AbRLEVJ7>;
	Wed, 5 Dec 2001 16:09:59 -0500
Date: Wed, 5 Dec 2001 16:09:57 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Troels Walsted Hansen <troels@thule.no>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: VIA acknowledges North Bridge bug (AKA Linux Kernel with Athlon
 optimizations bug)
In-Reply-To: <005b01c17dc2$1c244130$0300000a@samurai>
Message-ID: <Pine.LNX.4.30.0112051609200.21129-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So does this mean we will be seeing a patch that clears bits 6,7, and 8 in
register 55 on the northbridge soon?

-Calin

On Wed, 5 Dec 2001, Troels Walsted Hansen wrote:

> Remember the pci_fixup_via_athlon_bug() (AKA "Athlon bug stomper")
> function which went into kernel 2.4.14 after much discussion?
>
> Apparently the mysterious register 55 in the Northbridge controls a
> buggy Memory Write Queue timer. They finally acknowledged the problem
> when Nvidia drivers and Windows XP started pushing the hardware enough
> to trigger the bug...
>
> http://bbs.pcstats.com/viahardware/messageview.cfm?catid=19&threadid=863
> 8
>
>

