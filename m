Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTFDTZC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbTFDTZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:25:02 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:13442 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263894AbTFDTZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:25:02 -0400
Message-Id: <5.1.0.14.2.20030604213449.00af9c90@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 04 Jun 2003 21:38:26 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: I2C/Sensors 2.5.70
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: TbN-lUZHwev4aJboup6o3rFUgFRq-lUkGJ8rIioTgVMbwDZkH2exow@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > What is your .config? Are you sure you have selected a i2c chip driver?

Look at this line in the Makefile :
obj-$(CONFIG_I2C_SENSOR)        += i2c-sensor.o

There is no sign of CONFIG_I2C_SENSOR anywhere.

Margit

