Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262664AbUKQVoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262664AbUKQVoh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 16:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbUKQVmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 16:42:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:65466 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262646AbUKQVkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 16:40:20 -0500
Date: Wed, 17 Nov 2004 13:44:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: [patch 2.6.10-rc2] 3c59x: reload EEPROM values at rmmod for
 needy cards
Message-Id: <20041117134425.62034944.akpm@osdl.org>
In-Reply-To: <20041117160122.A4824@tuxdriver.com>
References: <20041117160122.A4824@tuxdriver.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John W. Linville" <linville@tuxdriver.com> wrote:
>
> 3c905 cards need an additional bit unmasked in the reset at rmmod or
> else they don't get reinitialized properly when the driver is reloaded.

This has been in -mm kernels since you first sent it out.  I'm intending to
hold off until post-2.6.10 so we get a full kernel cycle for any problems
to get shaken out.
