Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbVHLP37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbVHLP37 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 11:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbVHLP37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 11:29:59 -0400
Received: from khc.piap.pl ([195.187.100.11]:6916 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750833AbVHLP36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 11:29:58 -0400
To: Jean Delvare <khali@linux-fr.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: I2C block reads with i2c-viapro: testers wanted
References: <20050809231328.0726537b.khali@linux-fr.org>
	<42FA6406.4030901@cetrtapot.si>
	<20050810230633.0cb8737b.khali@linux-fr.org>
	<42FA89FE.9050101@cetrtapot.si>
	<20050811185651.0ca4cd96.khali@linux-fr.org>
	<m3fytgnv73.fsf@defiant.localdomain>
	<20050811215929.1df5fab0.khali@linux-fr.org>
	<m3iryctaou.fsf@defiant.localdomain>
	<20050811234946.0106afbe.khali@linux-fr.org>
	<m3br44t9cv.fsf@defiant.localdomain>
	<20050812082653.098a6aa3.khali@linux-fr.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 12 Aug 2005 17:29:55 +0200
In-Reply-To: <20050812082653.098a6aa3.khali@linux-fr.org> (Jean Delvare's
 message of "Fri, 12 Aug 2005 08:26:53 +0200")
Message-ID: <m3wtmri364.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <khali@linux-fr.org> writes:

> In I2C mode, you can even alternate as many read and write sequences you
> want in a single transaction. The target chip would of course need to
> know how to interpret such a transaction though. I've never seen this
> possibility used so far.

Is this mode supported by the common (such as VIA south bridge)
controllers?

> In SMBus mode, you are limited by the transaction types that have been
> defined, but a number of them are composed of a write transaction and a
> read transaction (separated by what is known as a "repeated start").
> Read Byte, Read Word, Read Block and Read I2C Block are such
> transactions. See the SMBus specification for the details.

Ok. I guest there are just different codes for 8- and 16-bit addressing.

> The I2C specifications are available from Philips. The SMBus
> specifications are available from smbus.org. Intel also has good
> datasheets for all ICH chips.
>
> http://www.semiconductors.philips.com/markets/mms/protocols/i2c/
> http://www.smbus.org/specs/
>
> More generally, see the lm_sensors project's links page:
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/useful_addresses.html
> and also:
> http://secure.netroedge.com/~lm78/docs.html
>
> Hope that helps,

Sure. Thanks.
-- 
Krzysztof Halasa
