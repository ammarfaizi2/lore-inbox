Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVFHB6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVFHB6r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 21:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVFHB6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 21:58:47 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:6707 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262064AbVFHB6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 21:58:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ISmyyOkdQV8+i56Ewfeil9FJ3isYRg6cIUQN8VdDwYtElnYKmH/2KqT2oFwm5EPp4dH6aXvMSEyAgnjJC3Ol1nRtcZG18fu7oJNLfSjqfjExOwkYIoU3eTxoaL69um7+4yvBSG7Yo5+Gd25CHvkRriXx7XjcYGsrO4u34kz6tPc=
From: =?iso-8859-1?q?S=F8ren_Lott?= <soren3@gmail.com>
To: Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Subject: Re: 2.6.12-rc6-mm1
Date: Tue, 7 Jun 2005 22:59:52 -0300
User-Agent: letmego
Cc: linux-kernel@vger.kernel.org
References: <20050607042931.23f8f8e0.akpm@osdl.org>
In-Reply-To: <20050607042931.23f8f8e0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506072259.52848.soren3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 June 2005 08:29, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc6/2.
>6.12-rc6-mm1/

[snip]

> +gregkh-i2c-i2c-Kconfig-update.patch
> +gregkh-i2c-i2c-pcf8574-cleanup.patch
> +gregkh-i2c-i2c-adm9240-docs.patch
> +gregkh-i2c-i2c-device-attr-lm90.patch
> +gregkh-i2c-i2c-device-attr-lm83.patch
> +gregkh-i2c-i2c-device-attr-lm63.patch
> +gregkh-i2c-i2c-device-attr-it87.patch
> +gregkh-i2c-hwmon-01.patch
> +gregkh-i2c-hwmon-02.patch
> +gregkh-i2c-hwmon-03.patch
>
>  i2c tree updates
>
> +i2c-chips-need-hwmon.patch
> +gregkh-i2c-hwmon-02-sparc64-fix.patch
>
>  Fix a few things in the i2c tree

[snip]

after those changes i don't get entries in /sys for my W83627THF chip. 
(p4c800-D, i875,ICH5)

relevant config parts:

CONFIG_HWMON=y
CONFIG_I2C=y
CONFIG_I2C_ISA=y
CONFIG_I2C_SENSOR=y
CONFIG_SENSORS_W83627HF=y

thanks.

-SL
