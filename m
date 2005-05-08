Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262856AbVEHMZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbVEHMZN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 08:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbVEHMZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 08:25:13 -0400
Received: from smtp11.wanadoo.fr ([193.252.22.31]:50274 "EHLO
	smtp11.wanadoo.fr") by vger.kernel.org with ESMTP id S262856AbVEHMZI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 08:25:08 -0400
X-ME-UUID: 20050508122505709.AD4BA1C000A4@mwinf1103.wanadoo.fr
Date: Sun, 8 May 2005 14:29:15 +0200
From: Philippe Elie <phil.el@wanadoo.fr>
To: li nux <lnxluv@yahoo.com>
Cc: Baruch Even <baruch@ev-en.org>, linux <linux-kernel@vger.kernel.org>
Subject: Re: oprofile: enabling cpu events
Message-ID: <20050508122915.GA737@zaniah>
References: <427CDA00.9040203@ev-en.org> <20050508072038.24894.qmail@web60512.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050508072038.24894.qmail@web60512.mail.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 May 2005 at 00:20 +0000, li nux wrote:

> Thanks Baruch,
> But, I am still hitting the same issue.
> I am using SuSE 2.6.5, but oprofile code looks
> similar.
> so i manually made that small change from if
> (cpu_model > 3) to if (cpu_model > 100), and did a
> make modules and make modules_install.
> Then inserted the fresh oprofile module.
> # opcontrol --setup  --event=CPU_CLK_UNHALTED
>  You cannot specify any performance counter events
>  because OProfile is in timer mode.
 

check if local apic support is turned on.

Philippe Elie

