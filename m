Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161221AbVIPSJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161221AbVIPSJd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161222AbVIPSJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:09:33 -0400
Received: from terminus.zytor.com ([209.128.68.124]:12995 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161221AbVIPSJd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:09:33 -0400
Message-ID: <432B0A47.7060909@zytor.com>
Date: Fri, 16 Sep 2005 11:09:11 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4N6EL-4Hq-3@gated-at.bofh.it> <4N6EL-4Hq-5@gated-at.bofh.it> <4N6EK-4Hq-1@gated-at.bofh.it> <4N6EX-4Hq-27@gated-at.bofh.it> <4N6Ox-4Ts-33@gated-at.bofh.it> <4N7AS-67L-3@gated-at.bofh.it> <E1EGKXl-0001Sn-GA@be1.lrz>
In-Reply-To: <E1EGKXl-0001Sn-GA@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> 
> What's supposed to happen if you concatenate a script from your french
> user and from your russian user, both using localized text, into one file?
> Unless you can guarantee every editor to correctly handle this case, all
> usage of 8-bit-characters should be disabled - NOT!
> 

Actually, it's quite easy to avoid problems by using UTF-8 consistently. 
   The 8-bit characters are oddballs and need to be treated specially, 
but look, guys, it's 2005 - UTF-8 should be the norm, not the exception.

	-hpa
