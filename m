Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbULVM2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbULVM2E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 07:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbULVM2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 07:28:04 -0500
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:43979 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S261976AbULVM2A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 07:28:00 -0500
Date: Wed, 22 Dec 2004 14:27:58 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: what/where is ss tool ?
Message-ID: <20041222122758.GB6627@m.safari.iki.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <00be01c4e819$aca09cd0$0e25fe0a@pysiak> <41C95B88.1070409@trash.net> <012f01c4e81f$f4bddbd0$0e25fe0a@pysiak>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <012f01c4e81f$f4bddbd0$0e25fe0a@pysiak>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 01:15:14PM +0100, Maciej Soltysiak wrote:
> Thanks Patrick!
> 
> Maybe we could add a line to the help so people, like me, that were
> not aware that ss exists.
> AFAICS ss appeared not so long ago, I think many distributions are
> still using versions that do not have ss.
> Or I may be wrong.
> 
> Regards,
> Maciej
> diff -ru linux.orig/net/ipv4/Kconfig linux/net/ipv4/Kconfig
> --- linux.orig/net/ipv4/Kconfig	2004-12-22 12:58:03.000000000 +0100
> +++ linux/net/ipv4/Kconfig	2004-12-22 13:00:36.000000000 +0100
> @@ -355,7 +355,8 @@
> 	default y
> 	---help---
> 	  Support for TCP socket monitoring interface used by native Linux
> -	  tools such as ss.
> +	  tools such as ss. ss comes from iproute2.
> +	  http://developer.osdl.org/dev/iproute2/

Add also "if you wish to view IPv6 addresses (Local/Peer Address) with ss,
IPv6 support must be built into the kernel (not as a module)."

> 	  If unsure, say Y.

-- 
