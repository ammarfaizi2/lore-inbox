Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWDTGyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWDTGyv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 02:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWDTGyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 02:54:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47570 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750807AbWDTGyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 02:54:50 -0400
Date: Wed, 19 Apr 2006 23:53:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christian Praehauser <cpraehaus@cosy.sbg.ac.at>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dvb-core: ULE fixes and RFC4326 additions (kernel
 2.6.16)
Message-Id: <20060419235349.2b1840c0.akpm@osdl.org>
In-Reply-To: <44465208.5030004@cosy.sbg.ac.at>
References: <44465208.5030004@cosy.sbg.ac.at>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Praehauser <cpraehaus@cosy.sbg.ac.at> wrote:
>
> +				static const u8 bc_addr[ETH_ALEN] = {0xFF,};

Was this really supposed to be 0xff, 0x00, 0x00, ...  or was it supposed to
be all ff's?
