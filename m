Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266156AbUFUINW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266156AbUFUINW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 04:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266154AbUFUINV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 04:13:21 -0400
Received: from uranus.md1.de ([217.160.177.133]:37810 "EHLO uranus.md1.de")
	by vger.kernel.org with ESMTP id S266156AbUFUINR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 04:13:17 -0400
Date: Mon, 21 Jun 2004 10:11:02 +0200
To: linux-kernel@vger.kernel.org
Cc: Gerd Knorr <kraxel@bytesex.org>
Subject: [PATCH][2.6][V4L] saa5246a Videotext driver update
Message-ID: <20040621081102.GA5961@t-online.de>
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

