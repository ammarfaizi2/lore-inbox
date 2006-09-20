Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWITHi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWITHi5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 03:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWITHi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 03:38:57 -0400
Received: from cantor2.suse.de ([195.135.220.15]:49807 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751265AbWITHiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 03:38:55 -0400
From: Andi Kleen <ak@suse.de>
To: Dmitriy Zavin <dmitriyz@google.com>
Subject: Re: [PATCH 1/4] x86_64/i386 thermal mce: Refactor thermal throttle reporting.
Date: Wed, 20 Sep 2006 09:38:51 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <11587201623432-git-send-email-dmitriyz@google.com> <11587201623187-git-send-email-dmitriyz@google.com>
In-Reply-To: <11587201623187-git-send-email-dmitriyz@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609200938.51215.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +
> +#include <linux/percpu.h>
> +#include <linux/cpu.h>
> +#include <asm/cpu.h>
> +#include <linux/notifier.h>
> +#include <asm/therm_throt.h>
> +
> +#ifdef CONFIG_X86_64


Sorry, no such ifdefs allowed. That is what I meant with making the merged code
worse than split code.
 
-Andi
