Return-Path: <linux-kernel-owner+w=401wt.eu-S932219AbXADAxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbXADAxw (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 19:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbXADAxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 19:53:52 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36653 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932219AbXADAxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 19:53:51 -0500
Date: Wed, 3 Jan 2007 16:50:20 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: i2c@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Why to I2c drivers not autoload like other PCI devices?
Message-ID: <20070103165020.4b277ebc@freekitty>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there some missing magic (udev rule?) that keeps i2c device modules
from loading? For example: the Intel i2c-i801 module ought to get loaded
automatically on boot up since it has a set of PCI id's that generate
the necessary module aliases. It would be better if I2C device's autoloaded
like other PCI devices.


-- 
Stephen Hemminger <shemminger@osdl.org>
