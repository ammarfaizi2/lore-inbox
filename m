Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVB1KnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVB1KnP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 05:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVB1KnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 05:43:15 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:57539 "EHLO xsmtp.ethz.ch")
	by vger.kernel.org with ESMTP id S261573AbVB1KnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 05:43:12 -0500
Message-ID: <4222F5BE.7000301@pixelized.ch>
Date: Mon, 28 Feb 2005 11:43:10 +0100
From: "Giacomo A. Catenazzi" <cate@pixelized.ch>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: "Ammar T. Al-Sayegh" <ammar@kunet.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/rmap.c:483!
References: <009d01c519e8$166768b0$7101a8c0@shrugy>	 <1109192040.6290.108.camel@laptopd505.fenrus.org>	 <003001c519f1$031afc00$7101a8c0@shrugy>	 <1109196074.6290.116.camel@laptopd505.fenrus.org>	 <007d01c519f9$7c9a5f50$7101a8c0@shrugy>	 <1109234333.6530.19.camel@laptopd505.fenrus.org>	 <004501c51a52$c4200380$7101a8c0@shrugy> <1109237429.6530.23.camel@laptopd505.fenrus.org>
In-Reply-To: <1109237429.6530.23.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2005 10:43:10.0288 (UTC) FILETIME=[4BB2A500:01C51D82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>but what what's the
>>penalty of preventing microcode from loading? a performance
>>hit?
> 
> 
> not even that; in theory a few cpu bugs may have been fixed. Nobody
> really knows since there's no changelog for the microcode..

You can see the processor bugs in intel website, i.e.:
ftp://download.intel.com/design/Xeon/specupdt/24967847.pdf

The following sentence (IMHO) meens that bug is corrected in microcode:
"Workaround: It is possible for the BIOS to contain a workaround
for this erratum."

ciao
	cate
