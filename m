Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVE1VEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVE1VEm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 17:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVE1VEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 17:04:42 -0400
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:10500 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261159AbVE1VE3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 17:04:29 -0400
Date: Sat, 28 May 2005 23:05:09 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i2c-parport disappeared from 2.6.11.9
Message-Id: <20050528230509.5370d50f.khali@linux-fr.org>
In-Reply-To: <20050528204836.GA20763@kestrel>
References: <20050528204836.GA20763@kestrel>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karel,

> Drivers -> I2C -> Busses -> Parallel port adapter disappeared in
> 2.6.11.9. However the source drivers/i2c/busses/i2c-parport.c
> and i2c-parport.h are still there.

No, it did not disappear. I'm using it. Check again. i2c-parport depends
on CONFIG_PARPORT, maybe that's what you are missing.

-- 
Jean Delvare
