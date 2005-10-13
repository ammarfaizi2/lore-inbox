Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbVJMSbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVJMSbO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 14:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVJMSbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 14:31:13 -0400
Received: from lana.hrz.tu-chemnitz.de ([134.109.132.3]:64977 "EHLO
	lana.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S932156AbVJMSbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 14:31:12 -0400
To: kernel-stuff@comcast.net (Parag Warudkar)
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug in handling of highspeed usb HID devices
References: <101220052332.3804.434D9D220007875C00000EDC220588644200009A9B9CD3040A029D0A05@comcast.net>
From: Christian Krause <chkr@plauener.de>
Date: Thu, 13 Oct 2005 20:05:09 +0200
In-Reply-To: <101220052332.3804.434D9D220007875C00000EDC220588644200009A9B9CD3040A029D0A05@comcast.net> (Parag
 Warudkar's message of "Wed, 12 Oct 2005 23:32:50 +0000")
Message-ID: <m3oe5tuwbu.fsf@gondor.middle-earth.priv>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Score: 0.0 (/)
X-Spam-Report: --- Start der SpamAssassin 3.1.0 Textanalyse (0.0 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: 8a8fa125b9cc748093f12ed7809f170b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 12 Oct 2005 23:32:50 +0000, Parag Warudkar wrote:
>> To avoid breaking things (my suggested patch has no impact on any other
>> usb driver) and to solve the problem shortly, I suggest to
>> use my patch and do some kind of refactoring later (You are right,
>> for a clean interface the interval parameter should have the same
>> meaning independend of the speed).

> Agreed. Looking at some of the callers, it will take some time and
> refactoring to fix all of them. For now, it makes sense to put your
> patch in if no one has an objection.

Ok, then only one question remains: How do I get this patch applied to
the official kernel tree?

Thanks & best regards,
Christian
