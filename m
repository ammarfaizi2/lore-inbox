Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbULDOvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbULDOvI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 09:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbULDOvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 09:51:08 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:29628 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262549AbULDOvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 09:51:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=rYNPq+74dU2uQjw32xRYZyXz/bFtWGHK9elb9vp/cJFmI98Va4K70xb5GLyPhy4+Q8Y94f9QAbFc54M/sfJx4ZDRE8ITIHlSyA8l480CP3EIT7+muq0ThSScx6LInfUBRad6m7QB0rO0IqQrbild1lEr05JxY9jGKGnSTXQ/Ask=
Message-ID: <35fb2e590412040651196e9484@mail.gmail.com>
Date: Sat, 4 Dec 2004 14:51:03 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: krishna <krishna.c@globaledgesoft.com>
Subject: Re: How to understand flow of kernel code
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41AE9E3E.9020307@globaledgesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41AE9E3E.9020307@globaledgesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Dec 2004 10:16:54 +0530, krishna
<krishna.c@globaledgesoft.com> wrote:

> Can Anyone tell me the tips/tricks/techniques/practices followed in
> understanding flow of Linux kernel code?

A really good idea would be to visit:

* http://user-mode-linux.sourceforge.net/

Build a UML kernel with support for kernel debugging and follow their
instructions for debugging the kernel using gdb or even perhaps ddd.
Then you can watch the flow of initialisation for yourself within the
UML. Note that this obviously doesn't have low level hardware specifc
handling for your architecture, but it's a good place to start messing
around.

Also, the usual plugs:

    * http://www.kernelnewbies.org/
    * http://www.tech9.net/rml/kernel_book/
    * http://www.xml.com/ldd/chapter/book/
    * http://safari.oreilly.com/ - Read Understanding the Linux kernel online

Jon.

P.S. You're probably not in the UK, but the next issue of Linux User &
Developer will have a feature on UML debugging. My rather biased
opinion is that it'll be interesting to you :-)
