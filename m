Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVAHXxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVAHXxV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 18:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVAHXxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 18:53:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:43427 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262076AbVAHXxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 18:53:18 -0500
Date: Sat, 8 Jan 2005 15:52:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] always enable regparm on i386
Message-Id: <20050108155248.25393222.akpm@osdl.org>
In-Reply-To: <20050108205049.GR14108@stusta.de>
References: <20050108205049.GR14108@stusta.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> The patch below always enables regparm on i386 (with gcc >= 3.0).
> 
>  With this patch, it should get a better testing coverage in -mm.
> 
>  If this doesn't cause any problems, I plan to send a patch to completely 
>  remove the CONFIG_REGPARM option after 2.6.11 will be released.

-mregparm has revealed at least two kernel bugs thus far.  The ability to
disable -mregparm is a useful diagnostic tool.

