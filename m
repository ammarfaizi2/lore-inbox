Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWEQJhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWEQJhy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 05:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWEQJhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 05:37:54 -0400
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:59060 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750712AbWEQJhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 05:37:53 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.17-rc4
Date: Wed, 17 May 2006 19:37:32 +1000
User-Agent: KMail/1.9.1
Cc: "Avuton Olrich" <avuton@gmail.com>, "Linus Torvalds" <torvalds@osdl.org>
References: <Pine.LNX.4.64.0605111640010.3866@g5.osdl.org> <3aa654a40605170133q8c4089fu7ae7626b9487399@mail.gmail.com>
In-Reply-To: <3aa654a40605170133q8c4089fu7ae7626b9487399@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605171937.32443.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 May 2006 18:33, Avuton Olrich wrote:
> Against latest git, don't know who to CC as maintainer :)
> If my assumption was correct:
>
> Signed-off-by: Avuton Olrich <avuton@gmail.com>
>
> diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
> index 8dfa305..5a01297 100644
> --- a/arch/i386/Kconfig
> +++ b/arch/i386/Kconfig
> @@ -466,8 +466,8 @@ config HIGHMEM64G
>  endchoice
>
>  choice
> -       depends on EXPERIMENTAL && !X86_PAE
> -       prompt "Memory split" if EMBEDDED
> +       depends on EXPERIMENTAL && !X86_PAE && !EMBEDDED
> +       prompt "Memory split"
>         default VMSPLIT_3G
>         help
>           Select the desired split between kernel and user memory.

See:
http://marc.theaimsgroup.com/?l=linux-kernel&m=114741988422813&w=2

-- 
-ck
