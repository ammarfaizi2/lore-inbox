Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263310AbRFACBI>; Thu, 31 May 2001 22:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263311AbRFACA5>; Thu, 31 May 2001 22:00:57 -0400
Received: from u-89-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.89]:9205
	"EHLO dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S263310AbRFACAp>; Thu, 31 May 2001 22:00:45 -0400
Date: Fri, 1 Jun 2001 03:57:39 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to know HZ from userspace?
Message-ID: <20010601035739.A1630@bacchus.dhis.org>
In-Reply-To: <20010530203725.H27719@corellia.laforge.distro.conectiva> <9f41vq$our$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9f41vq$our$1@cesium.transmeta.com>; from hpa@zytor.com on Wed, May 30, 2001 at 05:07:22PM -0700
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 05:07:22PM -0700, H. Peter Anvin wrote:

> Yes, but that's because the interfaces are broken.  The decision has
> been that these values should be exported using the default HZ for the
> architecture, and that it is the kernel's responsibility to scale them
> when HZ != USER_HZ.  I don't know if any work has been done in this
> area.

We have such patches in the MIPS tree but I never dared to send them to
Linus ...

  Ralf
