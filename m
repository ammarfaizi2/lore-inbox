Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271519AbTGQRXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 13:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271523AbTGQRXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 13:23:16 -0400
Received: from lightning.hereintown.net ([141.157.132.3]:40599 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S271519AbTGQRXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 13:23:13 -0400
Subject: Re: 2.6.0-t1-ac2: unable to compile glibc 2.3.2
From: Chris Meadors <twrchris@hereintown.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1058436931.5778.2.camel@laptop.fenrus.com>
References: <20030717114548.5f5d506d.martin.zwickel@technotrend.de>
	 <1058436931.5778.2.camel@laptop.fenrus.com>
Content-Type: text/plain
Message-Id: <1058463273.30267.7.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 17 Jul 2003 13:34:33 -0400
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19dChj-0007YU-GG*4sCn8233ZNQ*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-17 at 06:15, Arjan van de Ven wrote:

> you're probably better off using not-the-kernel headers for building
> glibc. eg on a RHL distro it's glibc-kernheaders package, other distros
> have different package names for these files.

In the past I would grab the headers of the kernel of which I compiled
glibc against.  glibc has #ifdefs in it to turn on/off some features
based on the kernel version.

Are there plans get a sane set of kernel headers together that can be
used by userspace (at least glibc) that properly describe the features
of the current kernel, so the C library may take advantage of them?

-- 
Chris

