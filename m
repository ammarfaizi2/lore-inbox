Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVDDKAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVDDKAI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 06:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVDDKAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 06:00:07 -0400
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:31758 "EHLO
	smtp-vbr10.xs4all.nl") by vger.kernel.org with ESMTP
	id S261202AbVDDKAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 06:00:01 -0400
In-Reply-To: <d5b47c419f6e5aa280cebd650e7f6c8f@mac.com>
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au> <424FE1D3.9010805@osvik.no> <524d7fda64be6a3ab66a192027807f57@xs4all.nl> <1112559934.5268.9.camel@tiger> <d5b47c419f6e5aa280cebd650e7f6c8f@mac.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3821024b00b47598e66f504c51437f72@xs4all.nl>
Content-Transfer-Encoding: 7bit
Cc: Kenneth Johansson <ken@kenjo.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
       linux-kernel@vger.kernel.org, Dag Arne Osvik <da@osvik.no>
From: Renate Meijer <kleuske@xs4all.nl>
Subject: Re: Use of C99 int types
Date: Mon, 4 Apr 2005 12:05:29 +0200
To: Kyle Moffett <mrmacman_g4@mac.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 4, 2005, at 12:08 AM, Kyle Moffett wrote:

> On Apr 03, 2005, at 16:25, Kenneth Johansson wrote:
>> But is this not exactly what Dag Arne Osvik was trying to do ??
>> uint_fast32_t means that we want at least 32 bits but it's OK with
>> more if that happens to be faster on this particular architecture.
>> The problem was that the C99 standard types are not defined anywhere
>> in the kernel headers so they can not be used.
>
> Uhh, so what's wrong with "int" or "long"?

My point exactly, though I agree with Kenneth that adding the C99 types
would be a Good Thing.

> GCC will generally do the right thing if you just tell it "int".

And if you don't, you imply some special requirement, which, if none 
really exists, is
misleading.

Regards,

Renate.

timeo hominem unius libri

Thomas van Aquino

