Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271309AbTGQA7M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 20:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271310AbTGQA7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 20:59:12 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:35238 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S271309AbTGQA7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 20:59:04 -0400
Date: Thu, 17 Jul 2003 02:10:02 +0100
From: backblue <backblue@netcabo.pt>
To: Pedro Ribeiro <deadheart@netcabo.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Not showing ac2
Message-Id: <20030717021002.2f12f7db.backblue@netcabo.pt>
In-Reply-To: <3F16539F.9070503@netcabo.pt>
References: <3F16539F.9070503@netcabo.pt>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jul 2003 01:09:06.0273 (UTC) FILETIME=[04EB0D10:01C34C00]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hy Pedro,

Just check if the source was really patched, maybe the source does not patch de Makefile and did not changed the EXTRAVERSION var that is where it should be changed, maybe the -ac2 patch it's for 2.6.0-test1 original, and nor for 
2.6.0-test1-ac1, that's it, just edit the Makefile, and change the EXTRAVERSION to -ac2 and recompile everything and, your are done, you have uname -a, like you want.


On Thu, 17 Jul 2003 08:43:27 +0100
Pedro Ribeiro <deadheart@netcabo.pt> wrote:

> I've just installed the ac2 patch from a clean 2.6.0-test1 tree and when 
> I do uname -a it says 2.6.0-test1-ac1. Is that normal? The modules dir 
> (in /lib/modules) also says ac1.
> 
> PR
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
