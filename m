Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTDNUnM (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263686AbTDNUnM (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:43:12 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35771
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263637AbTDNUnK (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 16:43:10 -0400
Subject: RE: Subtle semantic issue with sleep callbacks in drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A261@orsmsx401.jf.intel.com>
References: <F760B14C9561B941B89469F59BA3A84725A261@orsmsx401.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050350202.26521.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Apr 2003 20:56:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-14 at 20:07, Grover, Andrew wrote:
> All I am saying is that on Windows, the driver gets no help from the
> BIOS, APM, or ACPI, but yet it restores the video to full working
> condition. I understand that this sounds complicated, but since there is
> an implementation that already does this then I think we have to assume
> it's possible. :) Perhaps we should start with older, simpler gfx hw, or
> maybe POST the bios, but only as an interim solution until gfx drivers
> get better in this area.

You might be suprised how much BIOS help they get. Im not at liberty to
discuss details but at least two vendors jump into bios space in their
ACPI recovery routines.

Older APM has compiled in support for a load of common video card
variants and also uses int10 on the resume 16bit path.

