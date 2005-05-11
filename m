Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVEKQ3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVEKQ3m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 12:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVEKQ3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 12:29:42 -0400
Received: from fmr18.intel.com ([134.134.136.17]:26527 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261940AbVEKQ3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 12:29:40 -0400
Date: Thu, 12 May 2005 00:29:50 +0800
From: "Yu, Luming" <luming.yu@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Pereira de Almeida <andre@cachola.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: acpi poweroff
Message-ID: <20050511162950.GA5486@linux.sh.intel.com>
Mail-Followup-To: =?iso-8859-1?Q?Andr=E9?= Pereira de Almeida <andre@cachola.com.br>,
	linux-kernel@vger.kernel.org
References: <427FC554.1070306@cachola.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <427FC554.1070306@cachola.com.br>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a clue to track down to the root.
What's your machine model and kernel version?
Thanks,
Luming
On 2005.05.09 17:17:24 -0300, André Pereira de Almeida wrote:
> When I try to poweroff my computer, it reboots.
> The only way to turn it off is to change
> 
> acpi_sleep_prepare(ACPI_STATE_S5);
> 
> to
> 
> acpi_sleep_prepare(ACPI_STATE_S4);
> 
> in the function acpi_power_off in the file drivers/acpi/sleep/poweroff.c.
> I think it's a buggy acpi controller.
> What's the side effect of this change?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
