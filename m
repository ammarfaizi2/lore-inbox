Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751783AbWEPMO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbWEPMO5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 08:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWEPMO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 08:14:57 -0400
Received: from canuck.infradead.org ([205.233.218.70]:48851 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751783AbWEPMO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 08:14:57 -0400
Subject: Re: [-mm patch] drivers/mtd/devices/docprobe.c: correct #if's
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
In-Reply-To: <20060516114644.GN6931@stusta.de>
References: <20060515005637.00b54560.akpm@osdl.org>
	 <20060516114644.GN6931@stusta.de>
Content-Type: text/plain
Date: Tue, 16 May 2006 13:14:31 +0100
Message-Id: <1147781671.27870.20.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-16 at 13:46 +0200, Adrian Bunk wrote:
> If we correct the names of the config options, the code might actually
> work as intended...

S'true. Applied; thanks.

I've dug out one or two of these devices from the toy cupboard -- I want
to make sure we get the new version of the driver, using the generic
NAND code, working with all of them... and then we can drop the old
drivers altogether.

-- 
dwmw2

