Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbTIQMu3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 08:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbTIQMu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 08:50:28 -0400
Received: from chaos.analogic.com ([204.178.40.224]:19848 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262746AbTIQMu1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 08:50:27 -0400
Date: Wed, 17 Sep 2003 08:51:56 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: sting sting <zstingx@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: socketI implementation 
In-Reply-To: <Sea2-F7uqdcXqnviIvr0000be54@hotmail.com>
Message-ID: <Pine.LNX.4.53.0309170843490.1057@chaos>
References: <Sea2-F7uqdcXqnviIvr0000be54@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Sep 2003, sting sting wrote:

> Hello,
>
> I had downloaded the tar.gz of glibc;
> I
> I am interested in the learning the network layer and
> implementation of  the socket API in glibc
> (calls like socket,bind,gethostbyname,etc.).
> I saw in the inet subdirectory on glibc that it seems that  these calls
> are eventually result in calls to methods in nss subdirectory.
>
> But I am not sure.
> Am I right in my assumption?
> or where I can find the implementation of methods like bind(), connect(),
> socket(), etc.
>
> regards
> sting
>

Wrong list. However, the interface to the network through the
kernel is __NR_socketcall (function 102).
You need to learn how to use `find`, `grep` and other Unix
tools to search large directory trees like glibc.
For instance, in glibc-2.3.1, a lot of utility functions
are in glibc-2.3.1/inet and a lot of socket interface code
is in glibc-2.3.1/unix/sysv/linux/i386/socket.S


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


