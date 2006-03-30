Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWC3Iam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWC3Iam (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWC3Iam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:30:42 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34518 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932114AbWC3Iam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:30:42 -0500
Date: Thu, 30 Mar 2006 10:30:41 +0200
From: Jan Kara <jack@suse.cz>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, Karsten Keil <kkeil@suse.de>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Jan Kara <jack@suse.cz>,
       David Woodhouse <dwmw2@infradead.org>,
       Sridhar Samudrala <sri@us.ibm.com>
Subject: Re: [patch 3/8] use list_add_tail() instead of list_add()
Message-ID: <20060330083041.GN9287@atrey.karlin.mff.cuni.cz>
References: <20060330081605.085383000@localhost.localdomain> <20060330081730.068972000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330081730.068972000@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch converts list_add(A, B.prev) to list_add_tail(A, &B)
> for readability.
> 
> CC: Karsten Keil <kkeil@suse.de>
> CC: Jan Harkes <jaharkes@cs.cmu.edu>
> CC: Jan Kara <jack@suse.cz>
> CC: David Woodhouse <dwmw2@infradead.org>
> CC: Sridhar Samudrala <sri@us.ibm.com>
> Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
  Acked-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
