Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVBLSvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVBLSvu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 13:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVBLSvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 13:51:50 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:51981 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261183AbVBLSvs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 13:51:48 -0500
Date: Sat, 12 Feb 2005 19:52:05 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Enrico Bartky <DOSProfi@web.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Maarten Deprez <maartendeprez@scarlet.be>, Greg KH <gregkh@suse.de>
Subject: Re: M7101
Message-Id: <20050212195205.1d89f3d2.khali@linux-fr.org>
In-Reply-To: <20050207034219.GA5620@colo.lackof.org>
References: <41DC59A4.1070006@web.de>
	<20050206152615.1ab7498c.khali@linux-fr.org>
	<20050207034219.GA5620@colo.lackof.org>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Will m7101.c be modified once quirks enabling the device?

m7101.c is for 2.4 kernels while the proposed quirk is to be merged into
2.6 kernels, so m7101.c will still be needed as is. That said, if
cleanups are made on the way to 2.6 and someone offers a patch that
ports these cleanups back to m7101.c, I'll be happy to apply it, of
course.

Thanks,
-- 
Jean Delvare
