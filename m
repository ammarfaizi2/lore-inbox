Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbTIXAGC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 20:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbTIXAGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 20:06:02 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:65473 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP id S261239AbTIXAGA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 20:06:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Richard J Moore <rasman@uk.ibm.com>
Organization: Linux Technoilogy Centre - RAS team
To: sysware@portoweb.com.br, linux-kernel@vger.kernel.org
Subject: Re: syscall hook
Date: Wed, 24 Sep 2003 01:01:27 +0000
User-Agent: KMail/1.4.1
References: <3f70d6f9.cec.16345@portoweb.com.br>
In-Reply-To: <3f70d6f9.cec.16345@portoweb.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200309240101.27794.rasman@uk.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can use kprobes to do it. Chech out the dprobes project website: 
http://www-124.ibm.com/linux/projects/dprobes/

Be sure to look at the kprobes patch.


On Tue 23 September 2003 11:27 pm, Bruno Castro da Silva wrote:
> Hi all,
>
> I need to put a hook on a syscall so I can monitor the usage
> of sockets. I'm trying to do so without having to recompile
> the kernel (eg by using modules). Can anyone give me a hint
> on how to achieve this?
>
> (Please, replies to my email to, not only to the list. I
> haven't subscribed to the list because I can't afford to
> receive 300+ emails a day)
>
>
> Thanks in advance,
>
> Bruno
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Richard J Moore
IBM Linux Technology Centre
