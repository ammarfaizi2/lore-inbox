Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbULaP72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbULaP72 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 10:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbULaP72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 10:59:28 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:13261 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262117AbULaP70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 10:59:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=toeRPC67ylnWvJziyaoK7FBs4I4PvZKxEna1+PMMZCUf8yDCAibwqu9aWMSQLTndjK4WJFNCKdlNt62iwQmwqsHrJv4nHBZb8fm1L0cVOw6AzkdCAjPDP/PVXuHqXCX1nb8QOsTi615JVaLlAJ5LSvsMPr3YGevjZ7DmCvNzHyc=
Message-ID: <53046857041231075944c6301d@mail.gmail.com>
Date: Fri, 31 Dec 2004 08:59:25 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
Reply-To: Jesse Allen <the3dfxdude@gmail.com>
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: ptrace single-stepping change breaks Wine
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0412310753400.10974@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <1104401393.5128.24.camel@gamecube.scs.ch>
	 <1104411980.3073.6.camel@littlegreen>
	 <200412311413.16313.sailer@scs.ch>
	 <1104499860.3594.5.camel@littlegreen>
	 <53046857041231074248b111d5@mail.gmail.com>
	 <Pine.LNX.4.58.0412310753400.10974@bigblue.dev.mdolabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2004 07:56:25 -0800 (PST), Davide Libenzi
<davidel@xmailserver.org> wrote:
> 
> I don't think Linus ever posted a POPF-only patch. Try to comment those
> lines in his POPF patch ...
> 
>        if (is_at_popf(child, regs))
>                return;
> 
> 
> - Davide
> 
> 


This is what I was thinking about doing.  I'll try it when I get back, thanks.

Jesse
