Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263936AbTD0Lnp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 07:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263944AbTD0Lnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 07:43:45 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:23190 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S263936AbTD0Lno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 07:43:44 -0400
Date: Sun, 27 Apr 2003 21:56:44 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.68-bk7: Where oh where have my sensors gone? (i2c)
Message-ID: <20030427115644.GA492@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I keep a-lookin but I can't find any data. Have I missed something?

# find | grep -i pii
./bus/pci/drivers/piix4 smbus
./bus/pci/drivers/piix4 smbus/00:07.3
./bus/pci/drivers/PIIX IDE
./bus/pci/drivers/PIIX IDE/00:07.1
# find | grep -i i2c
./bus/i2c
./bus/i2c/drivers
./bus/i2c/drivers/lm75
./bus/i2c/drivers/IT87xx
./bus/i2c/drivers/dev driver
./bus/i2c/devices
./devices/pci0/00:07.3/i2c-0
./devices/pci0/00:07.3/i2c-0/power
./devices/pci0/00:07.3/i2c-0/name
# find | grep -i sensor
# find | grep -i smbus
./bus/pci/drivers/piix4 smbus
./bus/pci/drivers/piix4 smbus/00:07.3

# grep '\(SENSORS\|I2C\)' .config | grep -v '^#'
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_PIIX4=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_LM75=y
CONFIG_I2C_SENSOR=y

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
