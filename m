Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263449AbTFGTpl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 15:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTFGTpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 15:45:41 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:43036 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263449AbTFGTpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 15:45:40 -0400
Date: Sat, 7 Jun 2003 12:59:24 -0700
From: Andrew Morton <akpm@digeo.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Console blanking: blank on demand
Message-Id: <20030607125924.54cd5695.akpm@digeo.com>
In-Reply-To: <20030607105306.GA572@elf.ucw.cz>
References: <20030607105306.GA572@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jun 2003 19:59:15.0453 (UTC) FILETIME=[45D0CAD0:01C32D2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> [I seen you did some changes to screen blanking...]
> 
> For pretty long time this is in my tree. It is pretty important for
> small machines where display takes as much power as rest of system...
> 
> What about applying?
> 								Pavel

- What key is it using?

- Is there somewhere under Documentation/ where the key should be documented?

- whitespace looks suspect.

- The timer is left running across rmmod.

