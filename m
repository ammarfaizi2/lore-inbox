Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266157AbUA1U2c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 15:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266167AbUA1U2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 15:28:31 -0500
Received: from fmr04.intel.com ([143.183.121.6]:65241 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S266157AbUA1U13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 15:27:29 -0500
Subject: Re: [PATCH] 2.4 ACPI dispatcher/dsmthdat.c warning fix
From: Len Brown <len.brown@intel.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: marcelo.tosatti@cyclades.com, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0020AE787@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0020AE787@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1075321633.2497.5.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 28 Jan 2004 15:27:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof,


You're correct, but the 2.4 and 2.6 trees already got this fix when they
updated to ACPICA 20041116 on Monday night.

thanks,
-Len

On Tue, 2004-01-27 at 16:54, Krzysztof Halasa wrote:
> Hi,
> 
> I think this is what the author meant, i.e. we don't need to
> substitute
> obj_desc = new_obj_desc there as it is done later in the file.
> 
> This patch doesn't change kernel behaviour, it only eliminates the
> warning message.
> 
> Please apply to 2.4 kernel tree. Thanks.
> --
> Krzysztof Halasa, B*FH
> 
> 

