Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTFDUBB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 16:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264027AbTFDUBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 16:01:01 -0400
Received: from web80103.mail.yahoo.com ([66.163.169.76]:11385 "HELO
	web80103.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264023AbTFDUBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 16:01:00 -0400
Message-ID: <20030604201429.78014.qmail@web80103.mail.yahoo.com>
Date: Wed, 4 Jun 2003 13:14:29 -0700 (PDT)
From: Jordan Breeding <jordan.breeding@sbcglobal.net>
Subject: Re: I2C/Sensors 2.5.70
To: Margit Schubert-While <margitsw@t-online.de>, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20030604213449.00af9c90@pop.t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check at the bottom of this page:
http://linus.bkbits.net:8080/linux-2.5/anno/drivers/i2c/chips/Kconfig@1.10?nav=index.html|src/|src/drivers|src/drivers/i2c|src/drivers/i2c/chips

2.5.x should be setting it for you if you have in fact
selected an i2c chip.

Jordan

--- Margit Schubert-While <margitsw@t-online.de>
wrote:
>  > What is your .config? Are you sure you have
> selected a i2c chip driver?
> 
> Look at this line in the Makefile :
> obj-$(CONFIG_I2C_SENSOR)        += i2c-sensor.o
> 
> There is no sign of CONFIG_I2C_SENSOR anywhere.
> 
> Margit
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

