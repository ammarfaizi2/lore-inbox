Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263358AbRFAEMg>; Fri, 1 Jun 2001 00:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263357AbRFAEMQ>; Fri, 1 Jun 2001 00:12:16 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:5127 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263358AbRFAEMI>; Fri, 1 Jun 2001 00:12:08 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: How to know HZ from userspace?
Date: 31 May 2001 21:12:00 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9f74mg$1it$1@cesium.transmeta.com>
In-Reply-To: <20010530203725.H27719@corellia.laforge.distro.conectiva> <9f41vq$our$1@cesium.transmeta.com> <20010601035739.A1630@bacchus.dhis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010601035739.A1630@bacchus.dhis.org>
By author:    Ralf Baechle <ralf@uni-koblenz.de>
In newsgroup: linux.dev.kernel
>
> On Wed, May 30, 2001 at 05:07:22PM -0700, H. Peter Anvin wrote:
> 
> > Yes, but that's because the interfaces are broken.  The decision has
> > been that these values should be exported using the default HZ for the
> > architecture, and that it is the kernel's responsibility to scale them
> > when HZ != USER_HZ.  I don't know if any work has been done in this
> > area.
> 
> We have such patches in the MIPS tree but I never dared to send them to
> Linus ...
> 

Please do.

	-=hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
