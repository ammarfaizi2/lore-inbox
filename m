Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUAYK2U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 05:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbUAYK2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 05:28:20 -0500
Received: from gamma.utc.fr ([195.83.155.32]:55729 "EHLO gamma.utc.fr")
	by vger.kernel.org with ESMTP id S263942AbUAYK2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 05:28:17 -0500
Message-ID: <1075026495.40139a3f3d946@mailetu.utc.fr>
Date: Sun, 25 Jan 2004 11:28:15 +0100
From: eric.piel@tremplin-utc.net
To: George Anzinger <george@mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, minyard@acm.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Incorrect value for SIGRTMAX
References: <1074979873.4012e421714b1@mailetu.utc.fr> <20040124143037.5116ccc9.akpm@osdl.org> <1074983859.4012f3b32e87a@mailetu.utc.fr> <40138A92.8000908@mvista.com>
In-Reply-To: <40138A92.8000908@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Spam-Checked-By: gamma.utc.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting George Anzinger <george@mvista.com>:

> If we are going to open this, I would like to eliminate the "MIGS_SIGEV"
> stuff. If you can wait till Monday...
Eliminating the special code for MIGS_SIGEV would be a great idea!


> Another issue is that this is the only place in the kernel where SIGRTMAX is
> used (or it was a few months ago).  If memory serves, it also seems that it
> is the wrong value in at least some archs.
Actually, it's not. That's exactly what the patch of Corey Minyard addressed.
Half a dozen arch were corrected and now SIGRTMAX means SIGRTMAX :-)

Eric

