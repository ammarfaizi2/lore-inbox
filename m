Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUF3UG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUF3UG5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 16:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUF3UFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 16:05:11 -0400
Received: from uranus.md1.de ([217.160.177.133]:25510 "EHLO uranus.md1.de")
	by vger.kernel.org with ESMTP id S262080AbUF3UEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 16:04:35 -0400
Date: Wed, 30 Jun 2004 22:04:13 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] saa5246a Videotext driver update
Message-ID: <20040630200413.GA8834@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: linux@MichaelGeng.de (Michael Geng)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I uploaded an update to the Videotext driver for the
SAA5246A videotext decoder in 

http://www.michaelgeng.de/linux/saa5246a-2.6.7.patch

The update only changes comments showing that the driver 
also works for the SAA5281 videotext decoder chip. 
This is not surprising because according to the data sheet of 
the SAA5281 it is compatible to the SAA5246A. I have tested 
this with a Siemens Multimedia Extension Board (MXB).

I also added MODULE_AUTHOR and MODULE_DESCRIPTION macros which
were missing up to now.

Patch comment:
V4L: saa5246a driver update, supports saa5281

Signed-off-by: Michael Geng <linux@MichaelGeng.de>

Michael

