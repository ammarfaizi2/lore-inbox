Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263863AbTDNTFg (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263859AbTDNTFd (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:05:33 -0400
Received: from AMarseille-201-1-4-175.abo.wanadoo.fr ([217.128.74.175]:50215
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263863AbTDNTEr (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 15:04:47 -0400
Subject: RE: Subtle semantic issue with sleep callbacks in drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Patrick Mochel <mochel@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A261@orsmsx401.jf.intel.com>
References: <F760B14C9561B941B89469F59BA3A84725A261@orsmsx401.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050347907.5575.89.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Apr 2003 21:18:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> All I am saying is that on Windows, the driver gets no help from the
> BIOS, APM, or ACPI, but yet it restores the video to full working
> condition. I understand that this sounds complicated, but since there is
> an implementation that already does this then I think we have to assume
> it's possible. :) Perhaps we should start with older, simpler gfx hw, or
> maybe POST the bios, but only as an interim solution until gfx drivers
> get better in this area.

It's definitely possible as MacOS does that as well. But I doubt
the card vendors will ever provide us with the necessary informations...

Ben.

