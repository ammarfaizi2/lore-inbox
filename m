Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWGCN2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWGCN2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 09:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWGCN2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 09:28:55 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:11388 "EHLO
	asav08.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1751157AbWGCN2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 09:28:55 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAPe0qESBSg
From: Dmitry Torokhov <dtor@insightbb.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: 2.6.17-mm6
Date: Mon, 3 Jul 2006 09:28:52 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, tigran@veritas.com,
       linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
References: <20060703030355.420c7155.akpm@osdl.org> <44A9013C.6070902@gmail.com> <44A90D2A.6060004@gmail.com>
In-Reply-To: <44A90D2A.6060004@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607030928.53435.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 July 2006 08:27, Michal Piotrowski wrote:
> diff -uprN -X linux-mm/Documentation/dontdiff linux-mm-clean/arch/i386/Kconfig linux-mm/arch/i386/Kconfig
> --- linux-mm-clean/arch/i386/Kconfig	2006-07-03 12:35:16.000000000 +0200
> +++ linux-mm/arch/i386/Kconfig	2006-07-03 14:07:15.000000000 +0200
> @@ -399,9 +399,9 @@ config X86_REBOOTFIXUPS
> 
>  config MICROCODE
>  	tristate "/dev/cpu/microcode - Intel IA32 CPU microcode support"
> +	depends on FW_LOADER

Wouldn't "select" be better here?

-- 
Dmitry
