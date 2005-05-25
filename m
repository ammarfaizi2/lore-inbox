Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVEYPHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVEYPHt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 11:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbVEYPHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 11:07:49 -0400
Received: from mailhub3.nextra.sk ([195.168.1.146]:63498 "EHLO
	mailhub3.nextra.sk") by vger.kernel.org with ESMTP id S262359AbVEYPHp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 11:07:45 -0400
Message-ID: <4294950D.2000102@rainbow-software.org>
Date: Wed, 25 May 2005 17:09:01 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Karel Kulhavy <clock@twibright.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: I2C EEPROM write access
References: <20050525125609.GA15412@kestrel.twibright.com>
In-Reply-To: <20050525125609.GA15412@kestrel.twibright.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karel Kulhavy wrote:
> Hello
> 
> Is it possible to use some Linux I2C driver to program an I2C EEPROM,
> for example 24C16?
> 
> I have noticed only read-only access to "DIMM eeproms". Are they
> 24C16-alike?

SPD EEPROMs on DIMMs are 24C02.

> Is there some reason why write driver is not present like users could
> inadvertently overwrite their DIMM eeproms? Do these eeproms have a
> protection against write?

The SPD EEPROMs should not be write protected - that's what 
specification says - so probably are not.

> I am mainly interested in an application where 24C16 is in-circuit
> connected to a PC and contents read and wrote (typically poking
> at firmware configuration of various devices).
> 
> CL<

-- 
Ondrej Zary
