Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932622AbVHOBXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbVHOBXL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 21:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbVHOBXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 21:23:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59295 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932622AbVHOBXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 21:23:09 -0400
Date: Sun, 14 Aug 2005 18:23:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Increasing PCIBIOS_MIN_IO to 0x4000 broke on-board nvidia audio
In-Reply-To: <42FFA861.5040106@etek.chalmers.se>
Message-ID: <Pine.LNX.4.58.0508141822250.3553@g5.osdl.org>
References: <42FFA861.5040106@etek.chalmers.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Aug 2005, Lukas Sandström wrote:
> 
> The commits 71db63acff69618b3d9d3114bd061938150e146b ([PATCH] increase
> PCIBIOS_MIN_IO on x86) and 0b2bfb4e7ff61f286676867c3508569bea6fbf7a
> (ACPI: increase PCIBIOS_MIN_IO on x86) shortly after -rc5 caused my
> on-board audio to stop working. See attached output from dmesg and lspci.

Thanks. Reverted for now - but we should revisit the changes after 2.6.13.

Thanks for debugging,

		Linus
