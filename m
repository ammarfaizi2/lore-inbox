Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932746AbVITHCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746AbVITHCQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 03:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932747AbVITHCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 03:02:16 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:27810 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S932746AbVITHCP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 03:02:15 -0400
Date: Tue, 20 Sep 2005 09:02:14 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lost Ticks
Message-ID: <20050920070214.GA4208@janus>
References: <432E3D4C.4070508@perkel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432E3D4C.4070508@perkel.com>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 09:23:40PM -0700, Marc Perkel wrote:
> Got a dual core Athlon 64 X2 on an Asus board using NVidia chipset and 
> getting lost ticks. The software clock of course is totally messed up. 
> I've scanned google for a solution and see others complaining about bad 
> code in the SMM BIOS. I have the latest bios and whatever they need to 
> fix - isn't.
> 
> So - what do I do to make it work?

See http://bugzilla.kernel.org/show_bug.cgi?id=5105

On the kernel command-line:

x86_64:	try "notsc"
i386:	try "clock=pit"

"nosmp" works but isn't fun.

-- 
Frank
