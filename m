Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWFFRuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWFFRuH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 13:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWFFRuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 13:50:07 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:22794 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1750830AbWFFRuG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 13:50:06 -0400
Date: Tue, 6 Jun 2006 19:50:02 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: Re: [PATCH] I2C: *write_block* doesn't modify the data - mark as
 const
Message-Id: <20060606195002.a22b4006.khali@linux-fr.org>
In-Reply-To: <m364jez6re.fsf@defiant.localdomain>
References: <m364jez6re.fsf@defiant.localdomain>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> The attached patch marks i2c_smbus_write_block_data() and
> i2c_smbus_write_i2c_block_data() buffers as const.
> 
> Signed-off-by: Krzysztof Halasa <khc@pm.waw.pl>

That's right. Applied, thanks.

-- 
Jean Delvare
