Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263023AbVEGLoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbVEGLoQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 07:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbVEGLoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 07:44:16 -0400
Received: from natjimbo.rzone.de ([81.169.145.162]:17830 "EHLO
	natjimbo.rzone.de") by vger.kernel.org with ESMTP id S263023AbVEGLoO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 07:44:14 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/4] ppc64: rename arch/ppc64/kernel/pSeries_pci.c
Date: Sat, 7 May 2005 13:31:52 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <200504200149.22063.arnd@arndb.de> <200504200152.58965.arnd@arndb.de> <17018.64606.662481.104228@cargo.ozlabs.ibm.com>
In-Reply-To: <17018.64606.662481.104228@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505071331.53944.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Freedag 06 Mai 2005 07:10, Paul Mackerras wrote:
> Hmmm, you rename pSeries_pci.c to rtas_pci.c and then in the next
> patch you recreate pSeries_pci.c and move some stuff from rtas_pci.c
> into it.  Could we have one patch that creates rtas_pci.c and just
> moves stuff from pSeries_pci.c to it?

Sure. I wanted to make it easier to review as the rename patch is
trivial and the second patch is less to read than the combined one.
In my next update I will fold the two together.

	Arnd <><
