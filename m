Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129480AbQLGOmk>; Thu, 7 Dec 2000 09:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129455AbQLGOmb>; Thu, 7 Dec 2000 09:42:31 -0500
Received: from [62.172.234.2] ([62.172.234.2]:64840 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S129480AbQLGOmQ>;
	Thu, 7 Dec 2000 09:42:16 -0500
Date: Thu, 7 Dec 2000 14:13:04 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Kotsovinos Vangelis <kotsovin@ics.forth.gr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Microsecond accuracy
In-Reply-To: <Pine.LNX.4.21.0012071233420.970-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0012071411170.970-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Tigran Aivazian wrote:

> Hi,
> 
> How about TSC? I know this has disadvantages such as:
> 
> a) not all machines have TSC

while we are on this subject, please let me emphasize that you should
_not_ be using cpuid instruction to detect the presence of TSC but should
parse the /proc/cpuinfo file. There are many valid reasons why Linux's
idea of TSC presence may not be the same as hardware's (cpuid
instruction) idea.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
