Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267659AbUJRWof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267659AbUJRWof (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 18:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267662AbUJRWoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 18:44:34 -0400
Received: from holomorphy.com ([207.189.100.168]:55714 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267659AbUJRWod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 18:44:33 -0400
Date: Mon, 18 Oct 2004 15:44:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jim Nelson <james4765@verizon.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: More patches to arch/sparc/Kconfig [2 of 5]
Message-ID: <20041018224429.GH5607@holomorphy.com>
References: <41738FD4.5020008@verizon.net> <20041018102738.GF5607@holomorphy.com> <41744695.4020406@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41744695.4020406@verizon.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 06:41:25PM -0400, Jim Nelson wrote:
> You may be right about openpromfs.  How's this instead:
> diff -u  arch/sparc/Kconfig.orig arch/sparc/Kconfig
> --- arch/sparc/Kconfig.orig	2004-10-16 09:53:49.626021592 -0400
> +++ arch/sparc/Kconfig	2004-10-18 18:38:05.125374024 -0400
> @@ -248,7 +248,10 @@
>  	  -t openpromfs none /proc/openprom".
>  
>  	  To compile the /proc/openprom support as a module, choose M here: the
> -	  module will be called openpromfs.  If unsure, choose M.
> +	  module will be called openpromfs.
> +
> +	  Only choose N if you know in advance that you will not need to modify
> +	  OpenPROM settings on the running system.
>  
>  source "fs/Kconfig.binfmt"

This looks fine to me.


-- wli
