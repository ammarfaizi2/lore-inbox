Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWGEOlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWGEOlk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 10:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWGEOlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 10:41:40 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:43662 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964894AbWGEOlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 10:41:40 -0400
Date: Wed, 5 Jul 2006 16:41:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, bernds_cb1@t-online.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] FRV: Introduce asm-offsets for FRV arch
Message-ID: <20060705144138.GA26545@mars.ravnborg.org>
References: <20060705132409.31510.22698.stgit@warthog.cambridge.redhat.com> <20060705132419.31510.92219.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060705132419.31510.92219.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David.

 --- a/arch/frv/kernel/break.S
> +++ b/arch/frv/kernel/break.S
> @@ -9,11 +9,12 @@
>   * 2 of the License, or (at your option) any later version.
>   */
>  
> -#include <linux/sys.h>
> +#include <linux/config.h>

It is no loner needed to include <linux/config.h>.

	Sam
