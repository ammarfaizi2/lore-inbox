Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030392AbWJXOX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbWJXOX0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 10:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWJXOX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 10:23:26 -0400
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:29705 "EHLO
	smtp-vbr15.xs4all.nl") by vger.kernel.org with ESMTP
	id S1030392AbWJXOXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 10:23:25 -0400
Message-ID: <453E21DF.2070107@xs4all.nl>
Date: Tue, 24 Oct 2006 16:23:27 +0200
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: sata_via issue for VIA Epia SP8000 in 2.6.18[.1]?
References: <453B61D9.9060707@xs4all.nl> <453D5870.20308@gentoo.org>
In-Reply-To: <453D5870.20308@gentoo.org>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Daniel Drake wrote:
>> Some burbs:
>>
>> Links is up but  SStatus 113 SControl 300
>> qc timeout (cmd 0xec)
>> failed to IDENTIFY
>> This results in a kernel panic.
> 
> Try this patch:
> http://marc.theaimsgroup.com/?l=git-commits-head&m=116121959622812&q=raw

Works well on VIA Epia SP8000 (w/ SATA) and does not break EK8000 (just
PATA).
Thanks very much!

Kind regards,
Udo

