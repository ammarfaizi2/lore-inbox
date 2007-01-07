Return-Path: <linux-kernel-owner+w=401wt.eu-S932235AbXAIUlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbXAIUlK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 15:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbXAIUlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 15:41:10 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1558 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932235AbXAIUlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 15:41:09 -0500
Date: Sun, 7 Jan 2007 11:36:50 +0000
From: Pavel Machek <pavel@ucw.cz>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] Discuss a couple common errors in kernel-doc usage.
Message-ID: <20070107113649.GA4569@ucw.cz>
References: <Pine.LNX.4.64.0701051000560.3949@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701051000560.3949@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   Explain a couple of the most common errors in kernel-doc usage.
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> 
> ---
> 
>   seems useful to emphasize these issues since they occur occasionally
> in the source.
> 
> diff --git a/Documentation/kernel-doc-nano-HOWTO.txt b/Documentation/kernel-doc-nano-HOWTO.txt
> index 284e7e1..ba50129 100644
> --- a/Documentation/kernel-doc-nano-HOWTO.txt
> +++ b/Documentation/kernel-doc-nano-HOWTO.txt
> @@ -107,10 +107,14 @@ The format of the block comment is like this:
>   * (section header: (section description)? )*
>  (*)?*/
> 
> -The short function description cannot be multiline, but the other
> -descriptions can be (and they can contain blank lines). Avoid putting a
> -spurious blank line after the function name, or else the description will
> -be repeated!
> +The short function description ***cannot be multiline***, but the other

Can we shout a bit less?

							Pavel
-- 
Thanks for all the (sleeping) penguins.
