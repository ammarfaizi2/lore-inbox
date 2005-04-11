Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVDKJnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVDKJnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 05:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVDKJnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 05:43:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:53991 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261748AbVDKJns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 05:43:48 -0400
Date: Mon, 11 Apr 2005 02:43:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm3
Message-Id: <20050411024322.786b83de.akpm@osdl.org>
In-Reply-To: <1113209793l.7664l.1l@werewolf.able.es>
References: <20050411012532.58593bc1.akpm@osdl.org>
	<1113209793l.7664l.1l@werewolf.able.es>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Please do reply-to-all)

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> On 04.11, Andrew Morton wrote:
>  > 
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
>  > 
>  > 
> 
>  Is this not needed anymore ?
> 
>  --- 25/arch/i386/kernel/entry.S~nmi_stack_correct-fix	2005-04-05 00:02:48.000000000 -0700
>  +++ 25-akpm/arch/i386/kernel/entry.S	2005-04-05 00:02:48.000000000 -0700

Hopefully not. fix-crash-in-entrys-restore_all.patch works around the problem.
