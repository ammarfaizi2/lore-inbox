Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbUKSWOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbUKSWOo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUKSWDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:03:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:24218 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261642AbUKSWB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:01:29 -0500
Date: Fri, 19 Nov 2004 14:00:48 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [PATCH] I2C fixes for 2.6.10-rc2
Message-ID: <20041119220048.GE15956@kroah.com>
References: <20041119215935.GA15956@kroah.com> <20041119220001.GB15956@kroah.com> <20041119220015.GC15956@kroah.com> <20041119220030.GD15956@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119220030.GD15956@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2167, 2004/11/19 09:14:15-08:00, paubert@iram.es

[PATCH] I2C: minor comment fix

It seems so. BTW I hate wrong comments and happened to add one
in my patch. To fix my blunder, can you apply the appended one
line removal on top of Jean's patch.


Signed-off-by: Gabriel Paubert <paubert@iram.es>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/i2c-core.c |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	2004-11-19 11:40:37 -08:00
+++ b/drivers/i2c/i2c-core.c	2004-11-19 11:40:37 -08:00
@@ -1021,7 +1021,6 @@
 	                      I2C_SMBUS_WORD_DATA,&data);
 }
 
-/* Returns the number of bytes transferred */
 s32 i2c_smbus_write_block_data(struct i2c_client *client, u8 command,
 			       u8 length, u8 *values)
 {
