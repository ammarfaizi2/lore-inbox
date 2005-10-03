Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbVJCScM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbVJCScM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVJCScM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:32:12 -0400
Received: from fsmlabs.com ([168.103.115.128]:1721 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S932518AbVJCScL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:32:11 -0400
Date: Mon, 3 Oct 2005 11:38:19 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Natalie.Protasevich@unisys.com
cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] ES7000 platform update (i386)
In-Reply-To: <20051002230747.AFDF643F57@linux.site>
Message-ID: <Pine.LNX.4.61.0510031136530.1684@montezuma.fsmlabs.com>
References: <20051002230747.AFDF643F57@linux.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Natalie,

On Sun, 2 Oct 2005 Natalie.Protasevich@unisys.com wrote:

> @@ -62,6 +62,9 @@ static unsigned int base;
>  static int
>  es7000_rename_gsi(int ioapic, int gsi)
>  {
> +	if (es7000_plat == 2)
> +		return gsi;

Could you #define that number to something so you can immediately tell 
its Rascal/Zorro?

Thanks,
	Zwane
