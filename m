Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbTLOW4S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 17:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbTLOW4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 17:56:18 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:52680 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264286AbTLOW4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 17:56:12 -0500
From: Christian Borntraeger <kernel@borntraeger.net>
To: root@chaos.analogic.com, Felix von Leitner <felix-kernel@fefe.de>
Subject: Re: request: capabilities that allow users to drop privileges further
Date: Mon, 15 Dec 2003 23:55:41 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20031215213912.GA29281@codeblau.de> <Pine.LNX.4.53.0312151700320.15531@chaos>
In-Reply-To: <Pine.LNX.4.53.0312151700320.15531@chaos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312152355.41980.kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Mon, 15 Dec 2003, Felix von Leitner wrote:
> > I would like to be able to drop capabilities that every normal user
[...]
> > security problems further.  For example, I want my non-cgi web server
[...]
> >   * fork
> >   * execve
> >   * ptrace
[...]
> So you expect kernel support?  Normally, real people write or
> modify applications to provide for specific exceptions to
> the standards. They don't expect an operating system to
> modify itself to unique situations. That's not what
> operating systems have generally done in the past.
[...]

I dont agree. Policy is userspace but enforcing the policy very often needs 
kernel support.

Having ACL in 2.6 is an example where operating system already adopted to 
special needs. Furthermore, the kernel is already able to drop special 
capabilites, like module loading.  Having a generalised capabilites model 
is a good idea and there are already some more or less usable security 
modules.

cheers

Christian

