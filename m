Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbULQS5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbULQS5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 13:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbULQS5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 13:57:53 -0500
Received: from falcon30.maxeymade.com ([24.173.215.190]:14468 "EHLO
	falcon30.maxeymade.com") by vger.kernel.org with ESMTP
	id S262117AbULQS5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 13:57:50 -0500
Message-Id: <200412171857.iBHIvQkG012716@falcon30.maxeymade.com>
X-Mailer: exmh version 2.7.1.1 10/09/2004 with nmh-1.1
In-reply-to: <20041217183303.GA9561@dreamland.darkstar.lan> 
To: kronos@kronoz.cjb.net
cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Rashkae <rashkae@tigershaunt.com>
Subject: Re: Cannot mount multi-session DVD with ide-cd, must use ide-scsi 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Dec 2004 12:57:26 -0600
From: Doug Maxey <dwm@maxeymade.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Dec 2004 19:33:03 +0100, Kronos wrote:
...
> 		if (stat) return stat;
>+	
>+		toc->last_session_lba = be32_to_cpu(ms_tmp.ent.addr.lba);

Should that be le32_to_cpu?

> 	} else {
>

++doug

