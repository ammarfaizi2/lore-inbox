Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbWG1KFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbWG1KFY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 06:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbWG1KFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 06:05:24 -0400
Received: from khc.piap.pl ([195.187.100.11]:55202 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932603AbWG1KFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 06:05:23 -0400
To: Jean Delvare <khali@linux-fr.org>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cirrus-logic-framebuffer-i2c-support.patch
References: <200607050147.k651kxmT023763@shell0.pdx.osdl.net>
	<20060705165255.ab7f1b83.khali@linux-fr.org>
	<m3bqryv7jx.fsf_-_@defiant.localdomain> <44B196ED.1070804@pol.net>
	<m3irm5hjr0.fsf@defiant.localdomain> <44B226E8.40104@pol.net>
	<m3mzbh68g9.fsf@defiant.localdomain> <44B2398B.7040300@pol.net>
	<m3ejwt65of.fsf@defiant.localdomain> <44B248E4.2020506@pol.net>
	<m3u05p4mkx.fsf@defiant.localdomain> <44B26004.4050500@gmail.com>
	<m3r70tqxmt.fsf@defiant.localdomain> <44B2808F.8000901@pol.net>
	<m3ac7h6vxy.fsf@defiant.localdomain> <44B351CF.1090001@pol.net>
	<m34pxoh0pd.fsf@defiant.localdomain>
	<20060727225549.40b14655.khali@linux-fr.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 28 Jul 2006 12:05:20 +0200
In-Reply-To: <20060727225549.40b14655.khali@linux-fr.org> (Jean Delvare's message of "Thu, 27 Jul 2006 22:55:49 +0200")
Message-ID: <m3y7ueavtr.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jean Delvare <khali@linux-fr.org> writes:

> In practice, I would guess that both X and the framebuffer drivers only
> use the I2C/DDC channel to read the monitor's EDID at initialization
> time, so the risk of concurrent accesses is thin.

Yes. It's a bit different when I log console messages to the EEPROM
(connected to VGA DDC pins), but still... I don't have X on this
machine :-)

Looks like this very small project gets bigger.
-- 
Krzysztof Halasa
