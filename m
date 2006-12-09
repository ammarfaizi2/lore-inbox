Return-Path: <linux-kernel-owner+w=401wt.eu-S1758817AbWLIEso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758817AbWLIEso (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 23:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758826AbWLIEso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 23:48:44 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44799 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758817AbWLIEsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 23:48:43 -0500
Date: Fri, 8 Dec 2006 20:48:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH][resend] PNX8550 UART driver
Message-Id: <20061208204829.9f63ad2c.akpm@osdl.org>
In-Reply-To: <20061208180446.c86afebe.vitalywool@gmail.com>
References: <20061208180446.c86afebe.vitalywool@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006 18:04:46 +0300
Vitaly Wool <vitalywool@gmail.com> wrote:

> This patch adds UART support for PNX8330/8550/8950 Philips MIPS-based SoCs.

I expect it'll need updating for the terios->ktermios changes which were
merged today.

> Should be applied together with the PNX UART header fixup patch last sent yesterday (http://lkml.org/lkml/2006/12/7/147).

OK, after some struggle I found that.

> This stuff has been basically approved by rmk before he quitted maintaining serial core but hasn't been accepted yet due to merge window miss at that moment.

Please keep those emails to under 80-cols, thanks.
