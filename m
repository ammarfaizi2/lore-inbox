Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWGFFng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWGFFng (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 01:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbWGFFng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 01:43:36 -0400
Received: from mail1.bizmail.net.au ([202.162.77.164]:30669 "EHLO
	mail1.bizmail.net.au") by vger.kernel.org with ESMTP
	id S1030206AbWGFFnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 01:43:35 -0400
Message-ID: <1388.58.105.227.226.1152165308.squirrel@58.105.227.226>
Date: Thu, 6 Jul 2006 15:55:08 +1000 (EST)
Subject: struct i2c_adapter
From: yh@bizmail.com.au
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The struct i2c_adapter in 2.4 has following elements which are no longer
used in kernel 2.6:

void (*inc_use)(struct i2c_adapter *);
void (*dec_use)(struct i2c_adapter *);


We used MOD_INC_USE_COUNT for inc_use and MOD_DEC_USE_COUNT. Can anyone
confirm that is no longer required in kernel 2.6?

Thank you.

Jim

