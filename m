Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268100AbUJOBz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268100AbUJOBz0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 21:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268074AbUJOBz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 21:55:26 -0400
Received: from ozlabs.org ([203.10.76.45]:39389 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268100AbUJOBzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 21:55:23 -0400
Subject: Re: [PATCH] Realtime LSM
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jody McIntyre <realtime-lsm@modernduck.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, joq@io.com, torbenh@gmx.de
In-Reply-To: <20040930211408.GE4273@conscoop.ottawa.on.ca>
References: <1094967978.1306.401.camel@krustophenia.net>
	 <20040920202349.GI4273@conscoop.ottawa.on.ca>
	 <20040930211408.GE4273@conscoop.ottawa.on.ca>
Content-Type: text/plain
Message-Id: <1097805332.22673.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 11:55:32 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 07:14, Jody McIntyre wrote:
> +/* module parameters */
> +static int any = 0;			/* if TRUE, any process is realtime */
> +MODULE_PARM(any, "i");

Please node that MODULE_PARM is deprecated.  This looks like a job for
"module_param(any, bool, 0400)" or even "0644".  Please consider, and
for the others.

Thanks,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

