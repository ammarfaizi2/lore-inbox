Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWH0Tcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWH0Tcu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 15:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWH0Tcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 15:32:50 -0400
Received: from terminus.zytor.com ([192.83.249.54]:26065 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932251AbWH0Tcu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 15:32:50 -0400
Message-ID: <44F1F356.5030105@zytor.com>
Date: Sun, 27 Aug 2006 12:32:38 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Alon Bar-Lev <alon.barlev@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
 (ping)
References: <445B5524.2090001@gmail.com> <p73irkedod2.fsf@verdi.suse.de> <44F1E970.1050709@zytor.com> <200608272116.23498.ak@suse.de>
In-Reply-To: <200608272116.23498.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Just increasing that constant caused various lilo setups to not boot
> anymore. I don't know who is actually to blame, just wanting to
> point out that this "obvious" patch isn't actually that obvious.
> 

How would that even be possible (unless you recompiled LILO with the new 
headers)?  There would be no difference in the memory image at the point 
LILO hands off to the kernel.

In order to reproduce this we need some details about your "various LILO 
setups", or this will remain as a source of cargo cult programming.

	-hpa

