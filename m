Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272396AbTHIPnb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 11:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272401AbTHIPnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 11:43:31 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:56752 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S272396AbTHIPna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 11:43:30 -0400
Date: Sat, 9 Aug 2003 17:43:40 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>,
       qemu-devel@nongnu.org
Subject: Re: 2.6.0-test3 VGA console inevitable?
Message-ID: <20030809154340.GB5396@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Roman Zippel <zippel@linux-m68k.org>, qemu-devel@nongnu.org
References: <20030809152911.GA5396@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030809152911.GA5396@www.13thfloor.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 05:29:11PM +0200, Herbert Pötzl wrote:
> 
> Hi All!
> 
> it seems that the build system now does not allow
> to disable the VGA Console anymore :(
> 
> removing 
>   CONFIG_VGA_CONSOLE=y
> 
> or replacing with 
>   # CONFIG_VGA_CONSOLE is not set
> 
> gets automatically changed back to 
>   CONFIG_VGA_CONSOLE=y
> 
> on make?
> 
> system is x86, but what if I do not have a vga console at all?

ahh got it, one has to select 
 ->  Remove kernel features (for embedded systems)

then VT/VGA_CONSOLE can be removed ...

> best,
> Herbert
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
