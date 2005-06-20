Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVFUAQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVFUAQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVFUAQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:16:06 -0400
Received: from ns.suse.de ([195.135.220.2]:3264 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261794AbVFTXmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:42:23 -0400
From: Andreas Schwab <schwab@suse.de>
To: domen@coderock.org
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] kernel/power/disk.c string fix and if-less iterator
References: <20050620215712.840835000@nd47.coderock.org>
	<20050620221041.GI2222@elf.ucw.cz>
X-Yow: I have seen these EGG EXTENDERS in my Supermarket..
 ..  I have read the INSTRUCTIONS...
Date: Tue, 21 Jun 2005 01:42:18 +0200
In-Reply-To: <20050620221041.GI2222@elf.ucw.cz> (Pavel Machek's message of
	"Tue, 21 Jun 2005 00:10:41 +0200")
Message-ID: <jepsugwq79.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
>
>> The attached patch:
>> 
>> o  Fixes kernel/power/disk.c string declared as 'char *p = "...";' to be
>>    declared as 'char p[] = "...";', as pointed by Jeff Garzik.

'static const char p[] = "...";' would be even better.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
