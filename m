Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbUBDREW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 12:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbUBDRET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 12:04:19 -0500
Received: from adsl-64-109-89-108.dsl.chcgil.ameritech.net ([64.109.89.108]:30849
	"EHLO redscar") by vger.kernel.org with ESMTP id S263620AbUBDREQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 12:04:16 -0500
Subject: Re: 2.6: Voyager requires SMP?
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Han Boetes <han@mijncomputer.nl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040204082213.GT4443@fs.tum.de>
References: <20040127233402.6f5d3497.akpm@osdl.org>
	<20040128083645.GI2650@boetes.org> <20040130025142.GE3004@fs.tum.de>
	<20040130060028.GB13535@boetes.org>  <20040204082213.GT4443@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 04 Feb 2004 12:04:09 -0500
Message-Id: <1075914250.2028.77.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-04 at 03:22, Adrian Bunk wrote:
> @James:
> Is X86_VOYAGER=y and SMP=n a valid configuration that should compile, or 
> should X86_VOYAGER select SMP?

It is a valid (but rather rare configuration).  I know it's broken but
haven't paid much attention to fixing it.  Even the debian and Red Hat
boot systems for voyager have SMP kernels.

I'll look and see if there's a quick fix.

James


