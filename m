Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWEHV3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWEHV3J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 17:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWEHV3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 17:29:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26541 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750838AbWEHV3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 17:29:07 -0400
Date: Mon, 8 May 2006 14:31:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: balbir@in.ibm.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com
Subject: Re: [updated] [Patch 5/8] taskstats interface
Message-Id: <20060508143139.2f1c7623.akpm@osdl.org>
In-Reply-To: <20060504184011.GB6966@in.ibm.com>
References: <20060502061829.GB22607@in.ibm.com>
	<20060504184011.GB6966@in.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <balbir@in.ibm.com> wrote:
>
> +
> +	if ((rc = genl_register_ops(&family, &taskstats_ops)) < 0)
> +		goto err;

	rc = genl_register_ops(&family, &taskstats_ops);
	if (rc < 0)
		goto err;

please.

