Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbRC3A4s>; Thu, 29 Mar 2001 19:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129712AbRC3A4i>; Thu, 29 Mar 2001 19:56:38 -0500
Received: from bt-215-206.bta.net.cn ([202.106.215.206]:5892 "EHLO happy")
	by vger.kernel.org with ESMTP id <S129669AbRC3A4Z>;
	Thu, 29 Mar 2001 19:56:25 -0500
Date: Thu, 29 Mar 2001 23:10:14 -0800
From: hugang <linuxhappy@etang.com>
To: <Cedric.Lienart@prov-liege.be>, <linux-kernel@vger.kernel.org>
Subject: Re: how can I send a signal like kill
Message-Id: <20010329231014.7dbbc673.linuxhappy@etang.com>
In-Reply-To: <3AC30482.8BBF8539@prov-liege.be>
In-Reply-To: <3AC30482.8BBF8539@prov-liege.be>
X-Mailer: Sylpheed version 0.4.62 (GTK+ 1.2.9; i686-pc-linux-gnu)
Organization: soul
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2001 11:46:42 +0200
Cedric Lienart <Cedric.Lienart@prov-liege.be> wrote:

> how can I send a signal like 'kill (pid_t pid, int sig);' from a driver
> module to a user program. When I include signal.h in my module I have

	Try use force_sig(int sig, struct task_struct *p), Can read mm/oom_kill.c .
