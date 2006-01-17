Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWAQPBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWAQPBh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 10:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWAQPBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 10:01:36 -0500
Received: from mail.dvmed.net ([216.237.124.58]:48811 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751263AbWAQPBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 10:01:18 -0500
Message-ID: <43CD06BB.7050802@pobox.com>
Date: Tue, 17 Jan 2006 10:01:15 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Sbitnev <nwshuras@dezcom.mephi.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: SX8 stability issue
References: <204883.20060111160652@dezcom.mephi.ru> <43C55CAD.90609@pobox.com> <575186548.20060112141315@dezcom.mephi.ru>
In-Reply-To: <575186548.20060112141315@dezcom.mephi.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Alexander Sbitnev wrote: >>Well, the in-kernel sx8
	driver does not use NCQ at all, so you would >>have to have modified
	the driver to turn it on. Presumably this means >>there is a bug in
	your modifications? > > > Hmmm... Ok, driver doesn't care about NCQ at
	all, as i understood all NCQ work > performed by it's firmware. Then we
	have just a stability issue, not > directly linked to NCQ. Right? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Sbitnev wrote:
>>Well, the in-kernel sx8 driver does not use NCQ at all, so you would
>>have to have modified the driver to turn it on.  Presumably this means 
>>there is a bug in your modifications?
> 
> 
> Hmmm... Ok, driver doesn't care about NCQ at all, as i understood all NCQ work
> performed by it's firmware. Then we have just a stability issue, not
> directly linked to NCQ. Right?

I cannot say "correct", I can only guess "possibly yes."

	Jeff



