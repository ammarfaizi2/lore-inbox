Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266424AbUFQIzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266424AbUFQIzO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 04:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266427AbUFQIzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 04:55:14 -0400
Received: from aun.it.uu.se ([130.238.12.36]:33164 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266424AbUFQIzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 04:55:07 -0400
Date: Thu, 17 Jun 2004 10:55:00 +0200 (MEST)
Message-Id: <200406170855.i5H8t05x012553@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: david.vanhoose@comcast.net, phyprabab@yahoo.com, rml@ximian.com
Subject: Re: Programtically tell diff between HT and real
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2004 13:01:02 -0700 (PDT), Phy Prabab wrote:
>So, if I understand correctly, there is no way to know
>definitively if a cpu is HT or not?

Of course there is. Intel's documentation, in
particular the IA32 Volume 2 and 3 manuals and
application note 485 (CPUID) describe this. They
are downloadable as PDFs from developer.intel.com.

Use CPUID to retrieve the "number of siblings"
value. >1 implies HT actually enabled.
