Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTLPN2I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 08:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbTLPN2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 08:28:08 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:20010 "EHLO
	thoron.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261605AbTLPN2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 08:28:05 -0500
Date: Tue, 16 Dec 2003 08:27:24 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Felix von Leitner <felix-kernel@fefe.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: request: capabilities that allow users to drop privileges further
In-Reply-To: <20031215213912.GA29281@codeblau.de>
Message-ID: <Xine.LNX.4.44.0312160826290.16300-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003, Felix von Leitner wrote:

> I would like to be able to drop capabilities that every normal user has,
> so that network servers can limit the impact of possible future security
> problems further.  For example, I want my non-cgi web server to be able
> to drop the capabilities to
> 
>   * fork
>   * execve
>   * ptrace
>   * load kernel modules
>   * mknod
>   * write to the file system
> 
> and I would like to modify my smtpd to not be able to
> 
>   * fork
>   * execve
>   * ptrace
>   * load kernel modules
>   * mknod

You can specify policy under SELinux to acheive this (without modifying 
any applications).


- James
-- 
James Morris
<jmorris@redhat.com>


