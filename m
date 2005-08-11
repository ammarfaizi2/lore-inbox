Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbVHKTN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVHKTN2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 15:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVHKTN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 15:13:28 -0400
Received: from khc.piap.pl ([195.187.100.11]:3844 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932381AbVHKTN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 15:13:28 -0400
To: Jean Delvare <khali@linux-fr.org>
Cc: Hinko Kocevar <hinko.kocevar@cetrtapot.si>,
       LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: I2C block reads with i2c-viapro: testers wanted
References: <20050809231328.0726537b.khali@linux-fr.org>
	<42FA6406.4030901@cetrtapot.si>
	<20050810230633.0cb8737b.khali@linux-fr.org>
	<42FA89FE.9050101@cetrtapot.si>
	<20050811185651.0ca4cd96.khali@linux-fr.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 11 Aug 2005 21:13:20 +0200
In-Reply-To: <20050811185651.0ca4cd96.khali@linux-fr.org> (Jean Delvare's
 message of "Thu, 11 Aug 2005 18:56:51 +0200")
Message-ID: <m3fytgnv73.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <khali@linux-fr.org> writes:

> This is 1.033s down to 0.174s. This is just great, I2C block reads work
> and allow faster dumps, as expected.

Forgive my ignorance, but does it depend on the south bridge at all?
Isn't the block read capability just a function of EEPROM chip on
(I assume) RAM module?
-- 
Krzysztof Halasa
