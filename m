Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVKEIBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVKEIBV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 03:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVKEIBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 03:01:21 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:5904 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751206AbVKEIBV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 03:01:21 -0500
Date: Sat, 5 Nov 2005 09:01:37 +0100
From: Jean Delvare <khali@linux-fr.org>
To: James Chapman <jchapman@katalix.com>,
       Michael Burian <dynmail1@gassner-waagen.at>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.14] i2c chips: ds1337 2/2
Message-Id: <20051105090137.1a8c44b9.khali@linux-fr.org>
In-Reply-To: <436A71CF.5090309@katalix.com>
References: <436A71CF.5090309@katalix.com>
X-Mailer: Sylpheed version 2.0.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James, Michael, all,

> Patch for ds1337 i2c driver:
> 
> Fix BCD value errors when month=9, moving the increment inside the
> BIN2BCD macro.
> Fix similar code for the weekday value, just for consistency.

Ouch, this was a nasty one. Patch applied, thanks. I'll make sure it
makes it into mainline before 2.6.15.

-- 
Jean Delvare
