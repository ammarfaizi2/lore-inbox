Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263272AbTDCFK1>; Thu, 3 Apr 2003 00:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263273AbTDCFK1>; Thu, 3 Apr 2003 00:10:27 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:3824 "EHLO
	orion.mvista.com") by vger.kernel.org with ESMTP id <S263272AbTDCFK1>;
	Thu, 3 Apr 2003 00:10:27 -0500
Date: Wed, 2 Apr 2003 21:21:42 -0800
From: Jun Sun <jsun@mvista.com>
To: Madhavi <madhavis@sasken.com>
Cc: linux-kernel@vger.kernel.org, jsun@mvista.com
Subject: Re: Relocation overflow problem with MIPS
Message-ID: <20030402212142.A8057@mvista.com>
References: <Pine.LNX.4.33.0304031000280.23942-100000@pcz-madhavis.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0304031000280.23942-100000@pcz-madhavis.sasken.com>; from madhavis@sasken.com on Thu, Apr 03, 2003 at 10:10:13AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 10:10:13AM +0530, Madhavi wrote:
> 
> Hi
> 
> I am working on a device driver software for linux kernel version 2.4.19.
> My driver is a loadable module and the size of the module executable is
> approximately 1.4MB.
> 
> When I tried to load this module on x86, I didn't have any problems while
> installing it. On MIPS (R5432) CPU, this is giving the following problems:
> 
<snip>

More than likely the module is compiled with wrong compiler options.
Try to use the same options as compiling in-kernel modules.

BTW, such questions are more apropriate for linux-mips mailing list.
See www.linux-mips.org.

Jun

