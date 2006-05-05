Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751565AbWEEPMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbWEEPMS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 11:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWEEPMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 11:12:18 -0400
Received: from terminus.zytor.com ([192.83.249.54]:56482 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751565AbWEEPMQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 11:12:16 -0400
Message-ID: <445B62AC.90600@zytor.com>
Date: Fri, 05 May 2006 07:35:24 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Alon Bar-Lev <alon.barlev@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Barry K. Nathan" <barryn@pobox.com>, Adrian Bunk <bunk@fs.tum.de>,
       Riley@Williams.Name, tony.luck@intel.com, johninsd@san.rr.com
Subject: Re: [PATCH][TAKE 4] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256
 limit
References: <445B5524.2090001@gmail.com> <445B5C92.5070401@zytor.com> <445B610A.7020009@gmail.com>
In-Reply-To: <445B610A.7020009@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev wrote:
> 
> This should be a simple modification and I don't see why we
> should fight on the LILO problem (if exists) when we have
> the compile time config options alternative.
> 
> People who uses LILO may leave the default 256 value. Other
> may migrate to a higher one.
> 

This is cargo-cult programming, sorry.  Let's find out what the problem 
is and fix it right.  If that involves fixing LILO and/or dealing with a 
LILO bug, we have ways we can do that.

	-hpa
