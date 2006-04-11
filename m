Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWDKLVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWDKLVc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWDKLVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:21:32 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:7087 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750749AbWDKLVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:21:31 -0400
Date: Tue, 11 Apr 2006 13:21:26 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
cc: James Courtier-Dutton <James@superbug.co.uk>,
       linux list <linux-kernel@vger.kernel.org>
Subject: Re: Black box flight recorder for Linux
In-Reply-To: <m3psjqeeor.fsf@defiant.localdomain>
Message-ID: <Pine.LNX.4.61.0604111320080.928@yvahk01.tjqt.qr>
References: <44379AB8.6050808@superbug.co.uk> <m3psjqeeor.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Now, the question I have is, if I write values to RAM, do any of those
>> values survive a reset? If any did survive, one could use them to
>> store oops output in. [...]
>
>Interesting idea.
>
>I think the most trivial and reliable way would be to solder some
>I^2 or similar EEPROM chip to, for example, parallel port connector.
>

My turn. If the NVRAM was not so small on x86, you could easily put an Oops 
in there. Somewhat portable, I guess.


Jan Engelhardt
-- 
