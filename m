Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUDCMA3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 07:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUDCMA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 07:00:29 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:50565 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261712AbUDCMA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 07:00:28 -0500
Subject: Re: mtd - No flash chips recognised.
From: David Woodhouse <dwmw2@infradead.org>
To: David L <idht4n@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY2-F51ktUhFFWfBnj0002977e@hotmail.com>
References: <BAY2-F51ktUhFFWfBnj0002977e@hotmail.com>
Content-Type: text/plain
Message-Id: <1080993623.17863.123.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Sat, 03 Apr 2004 13:00:23 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-02 at 08:39 -0800, David L wrote:
> I'm trying to use 2.6.4 with a Mobile DiskOnChip.  I get the message
> "No flash chips recognised".  It looks like the DoC_IdentChip function
> in doc2001.c is finding a nand_flash_id of 0xa5, which isn't one of the
> ids listed in nand_ids.c.

Er, then it should surely be saying 'No recognised DiskOnChip found' or
something to that effect?

2.6 supports the DiskOnChip 2000, Millennium and Millennium Plus. There
is no support yet for newer devices. 

-- 
dwmw2


