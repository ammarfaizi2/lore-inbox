Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVCLP7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVCLP7E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 10:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVCLPzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 10:55:33 -0500
Received: from zeus.kernel.org ([204.152.189.113]:39585 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261942AbVCLPzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 10:55:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=i9X4p6uGrI9LV7xrZPwqgi8wYfJU8eM/i1ZABfstGQWKijojQ9EtZAG/I7fBx3CYhJcp8cf4HIKZrZEU1iz/vWmFkWyCkSB0w2jXhhEMnu9NoLchjk6Q7Xe8tlUgMARm1PZaS0ghgBhov4tpCkG3DiLlW3P/cgs1jyZlRtEudZs=
Message-ID: <6f6293f105031207535938c687@mail.gmail.com>
Date: Sat, 12 Mar 2005 16:53:42 +0100
From: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
Reply-To: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
To: John Richard Moser <nigelenki@comcast.net>
Subject: Re: binary drivers and development
Cc: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org
In-Reply-To: <4230CB07.3020904@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <423075B7.5080004@comcast.net> <423082BF.6060007@comcast.net>
	 <16944.49977.715895.8761@wombat.chubb.wattle.id.au>
	 <4230CB07.3020904@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005 17:32:39 -0500, John Richard Moser
<nigelenki@comcast.net> wrote:
> CPL=3 scares me; context switches are expensive.  can they have direct
> hardware access?  I'm sure a security model to isolate user mode drivers
> could be in place. . .
> 
> . . . huh.  Xen seems to run Linux at CPL=3 and give direct hardware
> access, so I guess user mode drivers are possible *shrug*.  Linux isn't
> a microkernel though.

Xen hypervisor runs at Ring0, while the guest OSs it supports run at Ring1.
