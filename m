Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUJRK1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUJRK1o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 06:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUJRK1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 06:27:44 -0400
Received: from holomorphy.com ([207.189.100.168]:414 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265395AbUJRK1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 06:27:41 -0400
Date: Mon, 18 Oct 2004 03:27:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jim Nelson <james4765@verizon.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: More patches to arch/sparc/Kconfig [2 of 5]
Message-ID: <20041018102738.GF5607@holomorphy.com>
References: <41738FD4.5020008@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41738FD4.5020008@verizon.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 05:41:40AM -0400, Jim Nelson wrote:
> Fixes typo in help in openpromfs.
> Apply against 2.6.9-rc4.
> diff -u  arch/sparc/Kconfig.orig arch/sparc/Kconfig
> --- ./arch/sparc/Kconfig.orig	2004-10-16 09:53:49.626021592 -0400
> +++ ./arch/sparc/Kconfig	2004-10-16 10:13:17.660148269 -0400
> @@ -248,7 +248,7 @@
>  	  -t openpromfs none /proc/openprom".
>  
>  	  To compile the /proc/openprom support as a module, choose M here: the
> -	  module will be called openpromfs.  If unsure, choose M.
> +	  module will be called openpromfs.  If unsure, choose N.
>  
>  source "fs/Kconfig.binfmt"

Except this one. I'm relatively sure this is not a typo.


-- wli
