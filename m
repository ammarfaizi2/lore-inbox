Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264767AbUEaUNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbUEaUNo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 16:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264772AbUEaUNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 16:13:44 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:28230 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S264767AbUEaUNm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 16:13:42 -0400
Date: Mon, 31 May 2004 22:16:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dan Kegel <dank@kegel.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: bringing back 'make symlinks'?
Message-ID: <20040531201623.GD8339@mars.ravnborg.org>
Mail-Followup-To: Dan Kegel <dank@kegel.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <40B36A0E.5080509@kegel.com> <20040525214328.GA2675@mars.ravnborg.org> <40B41367.5070607@kegel.com> <20040530105502.GA19882@mars.ravnborg.org> <40BB7C12.3040002@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BB7C12.3040002@kegel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2004 at 11:40:18AM -0700, Dan Kegel wrote:
> $ make ARCH=ppc prepare
>   HOSTCC  scripts/conmakehash
>   HOSTCC  scripts/kallsyms
>   CC      scripts/empty.o
> cc1: invalid option `multiple'
> cc1: invalid option `string'
> cc1: warning: unknown register name: r2
> make[1]: *** [scripts/empty.o] Error 1
> 
> Whoops, bad luck.  Let's try another:

OK - now I got the picture.

For 2.6 I'm not prepared to make a change that would allow what you need.
I know for 2.7 we will start to take a new approach with the kernel headers,
so I hope we do do it right there.
For 2.6 you have to live with the ugly workaround.

	Sam
