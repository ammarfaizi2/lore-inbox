Return-Path: <linux-kernel-owner+w=401wt.eu-S965250AbXATMMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965250AbXATMMb (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 07:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965231AbXATMMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 07:12:31 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:60623 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965250AbXATMMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 07:12:30 -0500
Message-ID: <45B207A4.7030606@student.ltu.se>
Date: Sat, 20 Jan 2007 13:14:28 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: ebiederm@xmission.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl.h: Comment out unused constants
References: <45B163E4.1040507@student.ltu.se> <45B1CE1D.9040309@zytor.com>
In-Reply-To: <45B1CE1D.9040309@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Richard Knutsson wrote:
>> Comment out unused constants in include/linux/sysctl.h.
>>
>> Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
>
> NAK as all hell.
>
> This file exports an interface to userspace, and thus should be 
> maintained indefinitely.
Oh, then I misunderstood Eric W. Bieders' message about comment out 
unused numbers.

But just of interest; what happens when userspace use a number not used 
in the kernel (except in sysctl.h)? Is it just a no-op?

Richard Knutsson

