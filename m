Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVIWICi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVIWICi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 04:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVIWICi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 04:02:38 -0400
Received: from dslsmtp.struer.net ([62.242.36.21]:2826 "EHLO
	dslsmtp.struer.net") by vger.kernel.org with ESMTP id S1750799AbVIWICh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 04:02:37 -0400
Message-ID: <12922.194.237.142.21.1127462553.squirrel@194.237.142.21>
In-Reply-To: <6017D66D-E5E5-4C0E-BE65-952BEA405F0C@freescale.com>
References: <CE56193B-A4BB-4557-87C0-BFCC6B9E7E5B@freescale.com>
    <20050922214940.5ab30894.rdunlap@xenotime.net>
    <669340F6-17D1-487D-A055-374077E96500@freescale.com>
    <6017D66D-E5E5-4C0E-BE65-952BEA405F0C@freescale.com>
Date: Fri, 23 Sep 2005 10:02:33 +0200 (CEST)
Subject: Re: kernel buildsystem error/warning?
From: "Sam Ravnborg" <sam@ravnborg.org>
To: "Kumar Gala" <kumar.gala@freescale.com>
Cc: "Gala Kumar K.-galak" <kumar.gala@freescale.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>
> After some more debug it appears that define rule_vmlinux__ is what's
> causing this and in my .config CONFIG_KALLSYMS is not defined.
>
> Not sure if that will help.  If I enable CONFIG_KALLSYMS the "error"
> goes away (which makes sense based on the rule_vmlinux__) define.

Good info - thanks.
I will fix it in the weekend.

   Sam


